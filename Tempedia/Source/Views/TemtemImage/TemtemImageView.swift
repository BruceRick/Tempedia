//
//  TemtemImageView.swift.swift
//  Tempedia
//
//  Created by Bruce Rick on 2024-01-15.
//

import SwiftUI
import ComposableArchitecture

struct TemtemImageView: View {
    let temtem: Temtem
    @State var storedTemtemImages: TemtemImages = TemtemImages(name: "")

    @Dependency(\.network.api) var api
    @Dependency(\.storage) var storage

    var body: some View {
        content
            .onAppear {
                let allStoredTemtemImages: [TemtemImages] = storage.getTemtemImages()
                storedTemtemImages = allStoredTemtemImages.first { $0.name == temtem.name } ??
                    TemtemImages(name: temtem.name)
            }
    }

    @ViewBuilder
    var content: some View {
        if let icon = storedTemtemImages.render,
           let image = UIImage(data: icon) {
            Image(uiImage: image)
                .resizable()
        } else if let icon = storedTemtemImages.renderWiki,
                  let image = UIImage(data: icon) {
            Image(uiImage: image)
                .resizable()
        } else if let icon = storedTemtemImages.icon,
                  let image = UIImage(data: icon) {
            Image(uiImage: image)
                .resizable()
        } else {
            image(url: api().fullURL(endpoint: .image(temtem.renderStaticImage)),
                  fallback: image(url: URL(string: temtem.wikiRenderStaticUrl),
                                  fallback: image(url: api().fullURL(endpoint: .image(temtem.icon)),
                                                  fallback: errorView)
                         )
            )
        }
    }

    @ViewBuilder
    func image(url: URL?, fallback: some View) -> some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    fallback
                } else {
                    loadingView
                }
            }
        } else {
            loadingView
        }
    }

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }

    var errorView: some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.circle")
                .foregroundColor(.red)
            Spacer()
        }
    }
}
