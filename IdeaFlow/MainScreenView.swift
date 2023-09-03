//
//  MainScreenView.swift
//  IdeaFlow
//
//  Created by Abhiraj on 08/08/23.
//

import SwiftUI

struct MainScreenView: View {
    @State private var notes: [Note] = [Note]()
    @State private var selectedNotes: [Note?] = [Note?]()
 
    
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(notes.indices, id: \.self) { index in
                    
                    
                    ListCellView2(notes: $notes,index:index,selectedNotes: $selectedNotes)
                        .listRowSeparatorTint(.black)
                        
                    
                    
                }
           
                .onMove(perform: moveRow)
                
                .listRowBackground(Color(red:0.11, green:0.14, blue: 0.19))
                .listRowSeparatorTint(.white)
                .listSectionSeparatorTint(.white)
                
                
                
                
            }
            
            .listStyle(InsetGroupedListStyle())
            
            
            .navigationBarTitle("IdeaFlow⚡️")
            .navigationBarItems(leading: EditButton(),trailing: AddButton2(notes: $notes))
            .accentColor(.purple)
            
        }
    }
    
    func moveRow(source: IndexSet, destination: Int) {
        self.notes.move(fromOffsets: source, toOffset: destination)
    }
    

    
}


@available(iOS 16.4, *)
struct ListCellView2: View {
    @Binding  var notes:[Note]
    var index:Int
    @State private var showSuggestions:Bool = false
    @Binding var selectedNotes: [Note?]
    @State var selectedIdeas:[String?] = [String?]()
    @State var selectedIdea:String? = nil
 
    
    
    @available(iOS 16.4, *)
    var body: some View {
        VStack
        {
            HStack {
                
                if selectedIdea != notes[index].title{
                    if !selectedNotes.isEmpty{
                        ForEach(selectedNotes,id:\.self) { note in
                            if let selectedNote = note{
                                if selectedNote == notes[index]{
                                    Text("🔗")

                                }
                            }
                        }}
                }
                    
                
                TextField("Idea\(index+1)",text:$notes[index].title)
                    .foregroundColor(.white)
                
                
                    .onChange(of:notes[index].title) { newValue in
                        if (newValue.contains("<>")){
                            showSuggestions = true
                            if let range = notes[index].title.range(of: "<>"){
                                notes[index].title = notes[index].title.replacingCharacters(in: range, with: "")
                            }
                            
                            
                        }
                        
                    }
                
                    .popover(isPresented:$showSuggestions,attachmentAnchor:.point(.trailing),arrowEdge: .leading) {
                        PopUpView2(notes:$notes,selectedNotes:$selectedNotes,selectedIdeas:$selectedIdeas,selectedIdea:$selectedIdea).presentationCompactAdaptation(
                            horizontal: .popover,
                            vertical: .popover)
                    }
                
                
                
                if !selectedIdeas.isEmpty{
                    if selectedIdea != notes[index].title{
                        HStack {
                            Text("<>")
                                .foregroundColor(.teal)
                            ForEach(selectedIdeas,id:\.self){idea in
                                if let selectedIdea = idea{
                                    
                                    Text(selectedIdea).background(Color.teal)
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .cornerRadius(3)
                                }
                            }
                            Button{
                                
                            }label: {
                                Image(systemName: "delete.right.fill")
                                    .renderingMode(.original)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(3)
                            }.onTapGesture {
                                selectedIdeas.removeAll()
                                selectedNotes.removeAll()
                            }
                        }
                        
                    }
                }
            }
            
            
        }
    }
}
    
    struct PopUpView2:View{
        @Environment(\.dismiss) var dismiss
        @Binding var notes:[Note]
        @Binding var selectedNotes: [Note?]
        @Binding var selectedIdeas:[String?]
        @Binding var selectedIdea:String?
        
  

        
        
        
        var body: some View{
       
            NavigationView {
                VStack {
                    List{
                        ForEach(notes, id:\.self) {
                            note in
                            if note.title.contains("<>"){
                                if let range = note.title.range(of: "<>") {
                                    let updatedString = note.title.replacingCharacters(in: range, with: "")
                                    Text(updatedString).onTapGesture {
                                        if !selectedIdeas.contains(updatedString){
                                            selectedIdeas.append(updatedString)
                                        }
                                     
                                        selectedIdea = updatedString
                                        if !selectedNotes.contains(note){
                                            selectedNotes.append(note)
                                        }
                                       
                                        dismiss()
                                    }
                                  
                                }
                               
                            }
                            else{
                                Text(note.title).onTapGesture {
                                    if !selectedIdeas.contains(note.title){
                                        selectedIdeas.append(note.title)
                                    }
                                 
                                    selectedIdea = note.title
                                    if !selectedNotes.contains(note){
                                        selectedNotes.append(note)
                                    }
                                   
                                    dismiss()
                                }
                                
                                
                            }
                         
                        }
                    }
                }
                
            }.frame(width: 150,height: 180)
        }
    }
    
    struct AddButton2: View {
        @Binding var notes: [Note]
        var body: some View {
            Button(action: {
                self.addTextToList()
            }) {
                Text("Add")
            }
        }
        private func addTextToList() {
            self.notes.append(Note(title:"", text:""))
            
        }
    }

    
 
    
    



struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
