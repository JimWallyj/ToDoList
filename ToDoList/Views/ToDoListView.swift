//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Jim Walejko on 3/31/26.
//

import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Query var toDos: [ToDo]
    @State private var sheetIsPresented = false
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(toDos){ toDo in
                    VStack (alignment: .leading){
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
                                DetailView(toDo: toDo)
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
                        
                        HStack{
                            Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                                .foregroundStyle(.secondary)
                            
                            if toDo.reminderIsOn{
                                Image(systemName: "calendar.badge.clock")
                                    .symbolRenderingMode(.multicolor)
                            }
                        }
                    }
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
        .modelContainer(ToDo.preview)
}
