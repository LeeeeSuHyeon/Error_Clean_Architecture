//
//  BeforeViewModel.swift
//  Error
//
//  Created by 이수현 on 6/23/25.
//

import Foundation
import RxSwift
import RxRelay

final class BeforeViewModel {
    private let useCase: UseCase
    private let disposeBag = DisposeBag()

    /// 사용자 입력
    enum Input {
        case viewDidLoad
    }

    /// View에 필요한 데이터
    struct Output {
        var data: Observable<String>
    }

    private let _input = PublishSubject<Input>()
    var input: AnyObserver<Input> { _input.asObserver() }

    private let _data = PublishSubject<String>()
    let output: Output

    init(useCase: UseCase = UseCase()) {
        self.useCase = useCase
        output = Output(
            data: _data.asObservable(),
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
                try await useCase.executeCoreData() // CoreData 접근
                try await useCase.executeNetwork()  // Network 접근
                _data.onNext("데이터 불러오기")
            } catch {
                // 에러 스트림 생성 및 스트림 해제
                _data.onError(error)
            }
        }
    }
}
