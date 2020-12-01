//
//  ConfirmPageView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ConfirmPageView: View {
    @EnvironmentObject var appModel : AppModel
    @State var selection : Int? = nil
    var body: some View {

        VStack(alignment: .leading, spacing: 40){
            Text("Organ for Everyone")
                .foregroundColor(Color.red.opacity(0.6))
                .font(.system(size: 35, weight: .bold, design: .rounded))
            HStack{
                Text("Organ: ").bold()
                Text(appModel.chosenOrgan.name)
            }
            HStack{
                Text("Patient: ").bold()
                Text(appModel.chosenPatient.name)
            }
            HStack{
                Text("Hospital: ").bold()
                Text(appModel.chosenHospital.name)
            }
            NavigationLink(destination: ResultView(), tag: 1, selection: $selection) {
                Button(action: {
                    self.selection = 1
                    appModel.retreiveMatching()
                }) {
                    HStack {
                        Text("Confirm and check result")
                    }
                }
                .foregroundColor(Color.white)
                .font(.system(size: 25, weight: .heavy, design: .rounded))
                .padding()
                .background(RoundedRectangle(cornerRadius:20).fill(Color.red.opacity(0.6)))
                .opacity(disableButton ? 0 : 1)
            }
        }.navigationTitle("Confirm")
        
        
    }
    var disableButton : Bool{
        appModel.chosenOrgan.name == "" || appModel.chosenPatient.name == "" || appModel.chosenHospital.name == ""
    }
}

struct ConfirmPageView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPageView()
    }
}
