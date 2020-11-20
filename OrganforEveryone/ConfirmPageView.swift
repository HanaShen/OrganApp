//
//  ConfirmPageView.swift
//  OrganforEveryone
//
//  Created by Hana Shen on 2020/11/20.
//

import SwiftUI

struct ConfirmPageView: View {
    @EnvironmentObject var appModel : AppModel
    var body: some View {
        Text(appModel.chosenPatient.name)
    }
}

struct ConfirmPageView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmPageView()
    }
}
