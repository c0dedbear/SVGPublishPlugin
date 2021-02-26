/**
*  SVGPlugin plugin for Publish
*  Copyright (c) Mikhail Medvedev 2021
*  MIT license, see LICENSE file for details
**/


import StrongTypedCSSPublishPlugin

/// An attribute for svg content
public enum SVGAttribute {

	case classString(String)
	case `class`(StrongTypeCSS)
	case classes([StrongTypeCSS])
	case width(Int)
	case height(Int)

	/// String value of attribute
	var attributeName: String {
		switch self {
		case .classString, .class, .classes: return "class"
		case .width: return "width"
		case .height: return "height"
		}
	}

	/// By default returns false for classes (because in svg file, they can be in many places)
	var isNeedToReplace: Bool {
		switch self {
		case .classString, .class, .classes: return false
		case .width, .height: return true
		}
	}
}
