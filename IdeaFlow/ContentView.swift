import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = [Note]()
 
    
    
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(notes.indices, id: \.self) { index in
                    
                    VStack {
                        Section {
                            TextField("Description", text: $notes[index].text)
                                .font(.body)
                                .foregroundColor(.black)
                                .padding(.vertical)
                            
                        } header: {
                            TextField("Idea",text:$notes[index].title)
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        
                        .listRowSeparatorTint(.black)
                        
                        
                    }
                    
                    .listRowBackground(Color(red:0.11, green:0.14, blue: 0.19))
                    .listRowSeparatorTint(.white)
                    .listSectionSeparatorTint(.white)
                    
                    
                    
                    
                }
                
                .listStyle(SidebarListStyle())
                
                
                .navigationBarTitle("IdeaFlow💡")
                .navigationBarItems(trailing: AddButton(notes: $notes))
                .accentColor(.teal)
                
            }
        }
        
    }

    
}



    
    
    struct AddButton: View {
        @Binding var notes: [Note]
        var body: some View {
            Button(action: {
                self.addTextToList()
            }) {
                Text("Add")
                   
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .frame(width:50,height: 50)
                    
                    
                    
                    
            }
        }
        private func addTextToList() {
            self.notes.append(Note(title:"", text:""))
            
        }
    }

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
    

