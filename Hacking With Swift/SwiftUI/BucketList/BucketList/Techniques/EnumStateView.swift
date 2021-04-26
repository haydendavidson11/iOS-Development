////
////  EnumStateView.swift
////  BucketList
////
////  Created by Hayden Davidson on 3/13/21.
////
//
//import SwiftUI
//
//struct EnumStateView: View {
////    enum for loadingState case
//    enum LoadingState {
//        case loading, success, failed
//    }
//    
//    var loadingState = LoadingState.loading
//    
//    var body: some View {
//        Group {
//            if loadingState == .success {
//                SuccessView()
//            } else if loadingState == .failed {
//                FailedView()
//            } else if loadingState == .loading {
//                LoadingView()
//            }
//        }
//    }
//}
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading...")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed.")
//    }
//}
//
//struct EnumStateView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnumStateView()
//    }
//}
