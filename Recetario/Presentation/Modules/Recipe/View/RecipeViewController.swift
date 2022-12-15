//
//  RecipeViewController.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit
import Combine
import SDWebImage

class RecipeViewController: UIViewController {

    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    var viewModel: RecipeViewModel!
    var input: RecipeViewModelInput!

    private var subscriptions = Set<AnyCancellable>()
    private var item: Recipe! {
        didSet {
            let vkey = item.video.vkey
            let thumb = item.video.thumb
            let urlString = "https://cdn7.kiwilimon.com/brightcove/\(vkey)/\(thumb)"
            let url = URL(string: urlString)
            coverImageView.sd_setImage(with: url)
            
            titleLabel.text = item.htmltitle
            descriptionLabel.text = item.recipeDescription
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.viewDidLoadPublisher.send(())
    }

    func bind() {
        let output = self.viewModel.bind(input: input)
        output
            .item
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    self.show(error: error)
                }
            } receiveValue: { item in
                self.item = item
            }
            .store(in: &subscriptions)
    }
}
