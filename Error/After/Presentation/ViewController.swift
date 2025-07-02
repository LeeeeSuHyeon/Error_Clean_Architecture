//
//  ViewController.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    private let viewModel: ViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        viewModel.input.onNext(.viewDidLoad)
    }

    /// Output 바인딩
    private func bindViewModel() {

        // 데이터 바인딩
        viewModel.output.data
            .bind(with: self) { owner, data in
                print(data)
            }.disposed(by: disposeBag)

        // 에러 바인딩
        viewModel.output.error
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, error in
                // Alert 띄우기 (error.localizedDescription)
                let alertViewController = UIAlertController(
                    title: error.alertTitle,             // Alert Title 설정
                    message: error.localizedDescription, // Alert Message 설정
                    preferredStyle: .alert
                )
                let confirmAction = UIAlertAction(title: "확인", style: .default)
                alertViewController.addAction(confirmAction)
                owner.present(alertViewController, animated: true)
            }.disposed(by: disposeBag)
    }
}

