//
//  AboutViewModel.swift
//  Rec-Col-Gnizer
//
//  Created by Michał Krupa on 26/04/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import UIKit

class AboutViewModel: NSObject {

    var sections: [String] {
        return ["About me", "Experience", "Contact"]
    }
    
    var cellData: [Any] {
    	return []
    }
}
