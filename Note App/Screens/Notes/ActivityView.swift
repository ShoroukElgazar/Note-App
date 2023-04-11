//
//  ActivityView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/10/23.
//

import SwiftUI

struct ActivityView: View {
    @State var vm : NoteVM
//    @State  var progress = 0.3
    var body: some View {
        VStack{
            RingActivityIndicator(progress: CGFloat(vm.progress), progressColor: .indigo, remainingColor: .indigo.opacity(0.3))
                .padding()

        }.onAppear{
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                vm.progress += 0.1
                if vm.progress >= 1.0 {
                    vm.progress = 0.0
                }
            }
        }
    }
}
extension ActivityView{
    static func build() -> some View{
        let vm = NoteVM(
                repos: Repos.build())
        return ActivityView(vm: vm)
    }
}


