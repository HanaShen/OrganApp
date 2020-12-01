//
//  DonorView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/27.
//

import SwiftUI

struct DonorView: View {
    @EnvironmentObject var appModel : AppModel
    @Binding var isShowingSheet : Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Donor: ")
                Text(appModel.matching[0].donorName)
            }
            HStack{
                Text("Age: ")
                Text(appModel.matching[0].donorAge)
            }
            HStack{
                Text("Index: ")
                Text(String(appModel.matching[0].donorIndex))
            }
            Button("Dismiss"){
                isShowingSheet.toggle()
            }.padding()
        }
    }
}

//struct DonorView_Previews: PreviewProvider {
//    static var previews: some View {
//        DonorView()
//    }
//}
