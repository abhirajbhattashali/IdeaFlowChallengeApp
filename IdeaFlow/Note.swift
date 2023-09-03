//
//  NotesClass.swift
//  IdeaFlow Coding Challenge
//
//  Created by Abhiraj on 03/08/23.
//

import Foundation
import SwiftUI

struct Note:Identifiable,Hashable,Equatable{
    let id = UUID()
    var title:String
    var text:String
}


