//
//  Factory+Register.swift
//  PhotoTestApp
//
//  Created by Dmitry Koshelev on 02.09.2023.
//

import Factory

extension Container {

    var networkService: Factory<NetworkServiceInterface> {
        Factory(self) { NetworkService() }
    }

}
