//
//  etaView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/12/1.
//

import SwiftUI

struct etaView: View {
    @EnvironmentObject var appModel : AppModel
    @Binding var isShowingSheet : Bool
    //@State var isShowingHospiatls : Bool = false
    var body: some View {
        VStack{
//            HStack{
//                Button(action:{isShowingHospiatls.toggle()}){
//                    Text("Hospitals Info")
//                }.sheet(isPresented: $isShowingHospiatls, content: {
//                    matchedHospiatlsView(isShowingSheet: $isShowingHospiatls)
//                })
//            }
            MapView()
            HStack{
                Text("ETA: " ).bold()
                if appModel.eta != nil{
                    Text(getTime()).opacity(0.5)
                }
            }
            Button("Dismiss"){
                isShowingSheet.toggle()
            }.padding()
        }
    }
    func getTime()->String{
        let formatter = DateFormatter()
        let calendar = Calendar.current
        let startDate = Date()
        let date = calendar.date(byAdding: .second, value: Int(appModel.eta!), to: startDate)
       // formatter.timeStyle = .full
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date!)
    }
}

//struct etaView_Previews: PreviewProvider {
//    static var previews: some View {
//        etaView()
//    }
//}
