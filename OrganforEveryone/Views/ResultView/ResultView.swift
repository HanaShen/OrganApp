//
//  ResultView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appModel : AppModel
    @State var isShowingDonor = false
    @State var isShowingETA = false
    var body: some View {
        if appModel.matching.count == 0{
            VStack(spacing: 20){
                Text("Matching Not Found")
                    .font(.headline)
                    .bold()
                    .padding()
                Image("organdonors")
                    .resizable()
                    .scaledToFit()
            }
        }
        else{
            VStack(alignment: .center, spacing: 10){
                HStack{
                    Text("\(appModel.chosenPatient.name) ").bold()
                    Text(" ---- ")
                    Text("\(appModel.chosenOrgan.name)").bold()
                }
                .fixedSize()
                .padding()
                Button(action:{self.isShowingDonor.toggle()}){
                    Text("Donor")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 25, weight: .heavy, design: .rounded))
                .padding()
                .background(RoundedRectangle(cornerRadius:20).fill(Color.red.opacity(0.6)))
                .sheet(isPresented: $isShowingDonor, content: {
                    DonorView(isShowingSheet: $isShowingDonor)
                })
                //
                Button(action:{
                    self.isShowingETA.toggle()
                    // appModel.retrieveMatchedHospitals()
                    
                }){
                    Text("ETA")
                }
                .foregroundColor(Color.white)
                .font(.system(size: 25, weight: .heavy, design: .rounded))
                .padding()
                .background(RoundedRectangle(cornerRadius:20).fill(Color.red.opacity(0.6)))
                .sheet(isPresented: $isShowingETA, content: {
                    etaView(isShowingSheet: $isShowingETA)
                })
              
            }.navigationTitle("Result")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    // next
                }
            }
        }
    }
    //    var next : some View{
    //        NavigationLink(
    //            destination: Text("result"),
    //            label: {
    //                Text("Next")
    //            })
    //    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}
