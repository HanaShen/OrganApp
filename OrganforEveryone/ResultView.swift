//
//  ResultView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/10/19.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text("Patient X ").bold()
                Text(" ---- ")
                Text("Organ Y").bold()
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
