import Foundation
import CoreLocation

@MainActor class GetLocation: Action {
    
    let latitudeVariableExpression: StringExpression?
    let longitudeVariableExpression: StringExpression?
    let errorTitleExpression: StringExpression?

    required init(object: JSONObject, registrar: Registrar) {
        latitudeVariableExpression = registrar.parseStringExpression(object: object["latitudeVariable"])!
        longitudeVariableExpression = registrar.parseStringExpression(object: object["longitudeVariable"])!
        errorTitleExpression = registrar.parseStringExpression(object: object["errorTitle"])
    }
    
    func run(screen: Screen) async throws(ActionError) {
        screen.stack?.showOverlay(true)
        defer { screen.stack?.showOverlay(false) }
        let provider = LocationProvider()
        do {
            let location = try await provider.requestCurrentLocation()
            if let latitudeVariable = latitudeVariableExpression?.compute(state: screen.state) {
                screen.state.numbers[latitudeVariable] = location.coordinate.latitude
            }
            if let longitudeVariable = longitudeVariableExpression?.compute(state: screen.state) {
                screen.state.numbers[longitudeVariable] = location.coordinate.longitude
            }
        } catch {
            switch error {
            case .authorizationDenied:
                throw .init(title: errorTitleExpression?.compute(state: screen.state), message: "Location access denied, check your device settings")
            case .noLocation:
                throw .init(title: errorTitleExpression?.compute(state: screen.state), message: "Location could not be determined, check your device settings")
            }
        }
    }
    
    enum LocationError: Error {
        case noLocation
        case authorizationDenied
    }

    class LocationProvider: NSObject, CLLocationManagerDelegate {
        private let manager = CLLocationManager()
        private var continuation: CheckedContinuation<CLLocation, Error>?

        override init() {
            super.init()
            manager.delegate = self
        }

        func requestCurrentLocation() async throws(LocationError) -> CLLocation {
            // Ensure location services are enabled and authorized
            guard CLLocationManager.locationServicesEnabled() else {
                throw LocationError.authorizationDenied
            }

            let status = manager.authorizationStatus
            guard status != .denied && status != .restricted else {
                throw LocationError.authorizationDenied
            }
            
            do {
                return try await withCheckedThrowingContinuation { continuation in
                    self.continuation = continuation
                    if status == .notDetermined {
                        manager.requestWhenInUseAuthorization()
                    } else {
                        manager.requestLocation()
                    }
                }
            } catch let error as LocationError {
                throw error
            } catch {
                throw .noLocation
            }
            
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = manager.authorizationStatus
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.requestLocation()
            default:
                continuation?.resume(throwing: LocationError.authorizationDenied)
                continuation = nil
            }
        }

        // Delegate methods
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                continuation?.resume(returning: location)
                continuation = nil
            } else {
                continuation?.resume(throwing: LocationError.noLocation)
                continuation = nil
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            continuation?.resume(throwing: error)
            continuation = nil
        }
    }
    
}



