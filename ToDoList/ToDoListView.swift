//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Jim Walejko on 3/31/26.
//

import SwiftUI

struct ToDoListView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink{
                    //  Destination view
                   DetailView()
                } label: {
                    Image(systemName: "eye")
                    Text("Show the new view!")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ToDoListView()
}
