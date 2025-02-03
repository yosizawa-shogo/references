//
//  StructuralIdentitySample.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/02/01.
//

import SwiftUI

/*
 Structural Identity
 View構造と型によって管理されるIdentityです。Explicit Identityは明示的に利用する一方で、Structural IdentityはView構造と型によって管理されるため、全てのViewに存在するIdentityだと言えます。

 Structural Identityを一言で言うと、Viewをn回書いたらn個別々のIdentityを持つ=n個実態が作られるです。より具体的に言うと、(body等の)Viewの型によって管理され、型情報上で別のViewと表現されているViewは別のIdentityを持ちます
 */
struct StructuralIdentitySample: View {
    @State var condition = true

    var body: some View {
        VStack {
            if condition {
                CounterView()
            } else {
                CounterView()
            }

            Button {
                condition.toggle()
            } label: {
                Text("toggle")
            }
        }
    }
}

#Preview {
    StructuralIdentitySample()
}


