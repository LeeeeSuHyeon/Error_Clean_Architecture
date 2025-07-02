//
//  BeforeViewController.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import UIKit
import RxSwift
import RxCocoa

final class BeforeViewController: UIViewController {
    private let viewModel: BeforeViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: BeforeViewModel = BeforeViewModel()) {
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
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                print(data)
            }, onError: { [weak self] error in // 에러 처리
                // Alert 띄우기 (error.localizedDescription)
                let alertViewController = UIAlertController(
                    title: "에러",             // Alert Title 설정
                    message: error.localizedDescription, // Alert Message 설정
                    preferredStyle: .alert
                )
                let confirmAction = UIAlertAction(title: "확인", style: .default)
                alertViewController.addAction(confirmAction)
                self?.present(alertViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}

