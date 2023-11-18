//
//  SignPickerItem.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct SignPickerItem: View {
    let sign: Sign
    let action: (() -> Void)
    
    var body: some View {
        Button(
            action: action,
            label: {
                Label(sign: sign)
            }
        )
        .buttonStyle(PickButtonStyle())
    }
}

private struct PickButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
    }
}

private struct Label: View {
    var sign: Sign
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(uiImage: sign.emoji.toImage(size: .init(width: 40, height: 40))!)
                .frame(width: 40, height: 40)
            
            Text(sign.name)
                .font(.montserrat(size: 16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.backgroundSecondary)
    }
}

#Preview {
    List {
        ForEach(Sign.allCases, id: \.self) { (sign) in
            SignPickerItem(
                sign: sign,
                action: {
                    print("test tap \(sign)")
                }
            )
        }
    }
}
