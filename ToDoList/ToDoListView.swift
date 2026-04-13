//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Jim Walejko on 3/31/26.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
//    var toDos = ["Learn Swift",
//                 "Build Apps",
//                 "Change the World",
//                 "Bring the Awesome",
//                 "Take a Vacation"]
    @Query var toDos: [ToDo]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(toDos){ toDo in
                    NavigationLink{
                        DetailView(toDo: ToDo())
                    }label: {
                        Text(toDo.item)
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
                    DetailView(toDo: ToDo())
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
        //.modelContainer(for: ToDo.self, inMemory: true)
        .modelContainer(for: ToDo.self, inMemory: true)
}
