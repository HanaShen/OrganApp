//
//  ResultView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI

struct ResultView: View {
    @EnvironmentObject var appModel : AppModel
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            HStack{
                Text("\(appModel.chosenPatient.name) ").bold()
                Text(" ---- ")
                Text("\(appModel.chosenOrgan.name)").bold()
            }.fixedSize()
            HStack{
                Text("ETA: " ).bold()
                Text("9:38 A.M, 11/8/2020")
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
