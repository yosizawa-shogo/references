//
//  ExplicitIdentitySample.swift
//  PlaygroundApp
//
//  Created by 吉澤翔吾 on 2025/02/01.
//

import SwiftUI

/*
 Explicit Identity
 明示的な値によって管理されるIdentityです。
 
 Explicit Identityとして指定している値が変化すると、Viewが別の要素として認識されます。
 文字通り、明示的に指定された場合のみ Explicit Identityを持つと考えられます。（コンポーネントが内部的に行っている場合はあるかもしれません）
 */
struct ExplicitIdentitySample: View {
    @State var id = 1
    var body: some View {
        VStack {
            CounterView()
                .id(id)
            
            Button {
                id += 1
            } label: {
                Text("change id")
            }
        }
    }
}

#Preview {
    ExplicitIdentitySample()
}


