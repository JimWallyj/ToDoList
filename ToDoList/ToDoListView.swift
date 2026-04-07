//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Jim Walejko on 3/31/26.
//

import SwiftUI

struct ToDoListView: View {
    let toDos = ["Learn Swift",
                 "Build Apps",
                 "Change the World",
                 "Bring the Awesome",
                 "Take a Vacation"]
    @State private var sheetIsPresented = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(toDos, id: \.self){ toDo in
                    NavigationLink{
                        DetailView(toDo: toDo)
                    }label: {
                            Text(toDo)
                        }
                    .font(.title2)
                    }
                }
            .navigationTitle("To Do List:")
            .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
            .listStyle(.plain)
            //  fullScreenCover(isPresented: $sheetIsPresented){
            .sheet(isPresented: $sheetIsPresented){
                NavigationStack {
                    DetailView(toDo: "")
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}
