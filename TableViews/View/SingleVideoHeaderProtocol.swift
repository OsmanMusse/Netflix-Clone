//
//  SingleVideoHeaderProtocol.swift
//  TableViews
//
//  Created by Mezut on 26/08/2019.
//  Copyright © 2019 Mezut. All rights reserved.
//

import UIKit


protocol SingleVideoHeaderDelegate {
    func isEpisodeLayout()
    func isTrailerLayout()
    func isMoreLikeThisLayout()
    func didTapLikeIcon()
}

extension SingleVideoHeaderDelegate {
    func isEpisodeLayout(){}
    func isTrailerLayout(){}
    func isMoreLikeThisLayout(){}
    func didTapLikeIcon(){}
}

protocol didSelectShareIcon {
    func didSelectShareIcon()
}
