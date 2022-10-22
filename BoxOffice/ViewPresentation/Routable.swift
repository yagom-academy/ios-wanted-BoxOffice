//
//  Routable.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

protocol Routable { func route(to Scene: SceneCategory) }

protocol SceneBuildable { func buildScene(scene: SceneCategory) -> Scenable? }

protocol Scenable { }

extension UIViewController: Scenable { }
