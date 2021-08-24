//
//  GridTableView.swift
//  UIParts
//
//  Created by Ryo Hanma on 2021/08/24.
//

import SwiftUI

struct GridTableView: View {
    @Binding var cells: [[String]]
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(cells, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(row, id: \.self) { column in
                        Text("\(column)")
                            .frame(width: 80)
                            .background(Color.white)
                    }
                }
            }
        }.background(Color.black)
        .border(Color.black)
    }
}

struct GridTableView_Previews: PreviewProvider {
    static let cells = [["a", "b", "c"], ["a", "b", "c"]]
    
    static var previews: some View {
        GridTableView(cells: .constant(cells))
    }
}
