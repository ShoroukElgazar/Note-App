//
//  AddNoteView.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//

import SwiftUI

struct AddNoteView: View {
    @State private var title = ""
    @State private var details = ""
    @State private var isCompleted = false
    @State var vm : NoteVM
    @Environment(\.managedObjectContext)  var viewContext
    @State private var edit = false
    @FocusState private var isFocused: Bool
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader{ proxy in
            VStack{
                TextField(Strings.title, text: $title)
                    .frame(height: 50)
                    .focused($isFocused)
                    

                TextEditorView(string: $details)
                    .padding(.top,2)
                    .padding(.bottom,20)
                    .focused($isFocused)
                   
                
                Spacer().frame(maxWidth: .infinity)

            }.padding()
                .errorAlert(showingAlert: $showingAlert, errorReason: Strings.addTitle)
                .onTapGesture {
                    edit = true
                }
                .toolbar
            {
                    ToolbarItem(placement: .navigationBarTrailing) {
                     EditNote()
                    }
                    
            }
        }
    }

    private func EditNote() -> some View {
        Group{
            if edit{
                Button(Strings.save) {
                    if title != ""{
                        edit = false
                        isFocused = false
                        addItem()
                    }else{
                       showingAlert  = true
                    }
                }.foregroundColor(.indigo)
            }else{
                EmptyView()
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            if self.title != "" {
            let note = createItem()
                vm.addItem(note: note)
            }else{
                showingAlert = true
            }
        }
    }
        private func createItem() -> NoteModel{
            let newItem = NoteModel(title: title, data: details, isCompleted: isCompleted, timeStamp: Date())
            return newItem
        }
}

extension AddNoteView{
    static func build() -> some View {
        let vm = NoteVM(
                repos: Repos.build())
        return AddNoteView(vm: vm)
    }
}


