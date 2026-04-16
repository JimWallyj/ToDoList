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
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else{
                                    print("😡 ERROR: Save after .toggle on ToDoListView did not work")
                                    return
                                }
                            }
                        
                        NavigationLink{
                            DetailView(toDo: ToDo())
                        }label: {
                            Text(toDo.item)
                        }
                        .swipeActions{
                            Button("Delete", role: .destructive) {
                                modelContext.delete(toDo)
                                guard let _ = try? modelContext.save() else{
                                    print("😡 ERROR: Save after .delete on ToDoListView did not work")
                                    return
                                }
                            }
                        }
                    }
                    .font(.title2)
                }
//                .onDelete { indexSet in
//                    indexSet.forEach({modelContext.delete(toDos[$0])})
//                    guard let _ = try? modelContext.save() else{
//                        print("😡 ERROR: Save after .delete on ToDoListView did not work")
//                        return
//                    }
//                }
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
