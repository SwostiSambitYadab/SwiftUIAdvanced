//
//  ErrorAlertBootCamp.swift
//  SwiftUIAdvanced
//
//  Created by hb on 24/12/24.
//

import SwiftUI

// Error
// Alert

// osstatus.com -> apple error descriptions

protocol AppAlert {
    var title: String { get }
    var subTitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert)) {
                alert.wrappedValue?.buttons
            } message: {
                if let subTitle = alert.wrappedValue?.subTitle {
                    Text(subTitle)
                }
            }
    }
}


struct ErrorAlertBootCamp: View {
    
    @State private var myAlert: CustomAlert? = nil
    
    var body: some View {
        Button("CLICK ME") {
            saveData()
        }
        .showCustomAlert(alert: $myAlert)
    }
        
    private func saveData() {
        
        let isSuccessful: Bool = false
        
        if isSuccessful {
            // do something
        } else {
            // error
            // let myError: Error = CustomError.urlError(error: URLError(.badURL))
            // error = myError
            
            // alert
            myAlert = .noInternetConnection(onTapOk: {
                debugPrint("Okay")
            }, onTapRetry: {
                debugPrint("Retry")
            })
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}

extension ErrorAlertBootCamp {
    
    enum CustomAlert: Error, LocalizedError, AppAlert {
        case noInternetConnection(onTapOk: () -> Void, onTapRetry: () -> Void)
        case dataNotFound(onTapRetry: () -> Void)
        case urlError(error: Error)
        
        var title: String {
            switch self {
            case .noInternetConnection:
                return "No Internet Connection"
            case .dataNotFound:
                return "Data Not Found"
            case .urlError(_):
                return "Error"
            }
        }
        
        var subTitle: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "There is an error loading data. Please try again!"
            case .urlError(error: let error):
                return "Error: \(error.localizedDescription)"
            }
        }
        
        var buttons: AnyView {
            AnyView(buttonsForAlert)
        }
        
        
        @ViewBuilder
        var buttonsForAlert: some View {
            switch self {
            case .noInternetConnection(let onTapOk, let onTapRetry):
                Button("OK") {
                    onTapOk()
                }
                
                Button("Retry") {
                    onTapRetry()
                }
            case .dataNotFound(let onTapRetry):
                Button("Retry") {
                    onTapRetry()
                }
            case .urlError(_):
                Button("OK") {
                    
                }
            }
        }
    }
}
