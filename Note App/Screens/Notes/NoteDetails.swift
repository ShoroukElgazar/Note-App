//
//  NoteDetails.swift
//  Note App
//
//  Created by Shorouk Mohamed on 4/6/23.
//

import SwiftUI

struct NoteDetails: View {
    @State var vm : NoteVM
    @ObservedObject var selectedNote: Note
    @Environment(\.managedObjectContext)  var viewContext
    @State var title = ""
    @State var details = ""
    @State private var isCompleted = false
    @State private var edit = false
    @State private var isDoneHidden = true
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var showShareSheet: Bool = false
    @State var shareSheetItems: [Any] = []
    @State private var showingAlert = false
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                VStack{
                    EditFields()
                                        
                }.padding()
                    .navigationBarBackButtonHidden(true)
                
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditNote()
                        }
                        ToolbarItem() {
                            ShareNoteBtn()
                        }
                        ToolbarItem() {
                            DeleteNoteBtn()
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            BackButton()
                        }
                    }.errorAlert(showingAlert: $showingAlert, errorReason: Strings.addTitle)
                    .sheet(isPresented: $showShareSheet, content: {
                        ActivityViewController(activityItems: self.$shareSheetItems)
                    })
            }

            
        }
    }
    
    private func EditFields() -> some View{
        VStack{
            TextField(Strings.title, text: $title)
                .frame(height: 50)
                .focused($isFocused)
                .onChange(of: title) { newValue in
                    isDoneHidden = false
                    if title != newValue{
                        edit = true
                    }
                }
            
            TextEditorView(string: $details)
                .padding(.top,2)
                .padding(.bottom,20)
                .focused($isFocused)
                .onChange(of: details) { newValue in
                    isDoneHidden = false
                    if details != newValue{
                        edit = true
                    }
                }
            
        }.onTapGesture {
            edit = true
        }
        
    }
    
    private func EditNote() -> some View {
        Group{
            if !isDoneHidden {
                Button(Strings.done) {
                    if title != ""{
                        isFocused = false
                        isDoneHidden = true
                        editNote()
                    }else{
                        showingAlert = true
                    }
                }.foregroundColor(.indigo)
            }else{
                EmptyView()
            }
        }
    }
    
    private func DetailsFields() -> some View{
        VStack{
            Text(selectedNote.title ?? Strings.title)
            Text(selectedNote.data ?? Strings.details )
        }
    }
    
    private func editNote() {
        withAnimation {
            selectedNote.title = title
            selectedNote.data = details
            selectedNote.isCompleted = isCompleted
            isFocused = false
            vm.editNote(note: vm.mapNoteEntityToModel(note: selectedNote))
        }
    }
    
    private func shareNote(item: Note){
        showShareSheet = true
        let shareItems = vm.shareNote(note: vm.mapNoteEntityToModel(note: item))
        shareSheetItems = shareItems
    }
    
    private func ShareNoteBtn() -> some View {
        Button(action: {
            shareNote(item: selectedNote)
        }) {
            Image(systemName: "square.and.arrow.up.fill")
        }
        .foregroundColor(.indigo)
    }
    
    private func DeleteNoteBtn() -> some View {
        Button(action: {
            vm.deleteNote(note: vm.mapNoteEntityToModel(note: selectedNote))
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "trash.fill")
        }
        .foregroundColor(.indigo)
    }
    private func BackButton() -> some View {
        Button(action: {
            if title != ""{
              
                if edit{
                    editNote()
                }
                presentationMode.wrappedValue.dismiss()
            }else{
                showingAlert = true
            }

        }) {
            HStack{
                Image(systemName: "chevron.backward")
                Text(Strings.back)
            }
        }
    }
}
