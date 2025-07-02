//
//  ViewModel.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation
import RxSwift
import RxRelay

final class ViewModel {
    private let useCase: UseCase
    private let disposeBag = DisposeBag()

    enum Input {
        case viewDidLoad
    }

    struct Output {
        var data: Observable<String>
        var error: Observable<AppError>
    }

    private let _input = PublishSubject<Input>()
    var input: AnyObserver<Input> { _input.asObserver() }

    private let _data = PublishSubject<String>()
    private let _error = PublishSubject<AppError>()
    let output: Output

    init(useCase: UseCase = UseCase()) {
        self.useCase = useCase
        output = Output(
            data: _data.asObservable(),
            error: _error.asObservable()
        )

        bindAction()
    }

    private func bindAction() {
        _input.subscribe(with: self) { owner, input in
            switch input {
            case .viewDidLoad:
                owner.fetchData()
            }
        }.disposed(by: disposeBag)
    }

    /// 데이터 불러오기
    private func fetchData() {
        Task {
            do {
                try await useCase.executeCoreData()
                try await useCase.executeNetwork()
                _data.onNext("데이터 불러오기")
            } catch {
                handleError(error)
            }
        }
    }

    /// 에러 핸들링
    private func handleError(_ error: Error) {
        // 받은 에러를 AppError 타입으로 변환 후 Output.error에 방출
        if let error = error as? AppError {
            _error.onNext(error)
            NSLog(error.debugDescription)
        } else {
            _error.onNext(AppError.unknown(error))
            NSLog(error.localizedDescription)
        }
    }
}

