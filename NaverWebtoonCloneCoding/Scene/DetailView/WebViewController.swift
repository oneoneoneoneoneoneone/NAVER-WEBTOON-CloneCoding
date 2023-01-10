//
//  WebViewController.swift
//  NaverWebtoonCloneCoding
//
//  Created by hana on 2023/01/11.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    var url: String = "https://msearch.shopping.naver.com/book/search?bookTabType=ALL&pageIndex=1&pageSize=40&sort=REL"
    var search: String = ""
    
//    var webViewGroup = UIView()
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        setWebView()
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func setWebView(){
        //웹 뷰에 대한 기본 속성
        let preferences = WKPreferences() //WKWebpagePreferences
//        preferences.allowsContentJavaScript = true
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        //웹 뷰와 javaScript 간의 상호작용을 관리
        let contentController = WKUserContentController()
        contentController.add(self, name: "bridge")
        
        //웹 뷰가 맨 처음 초기화될 때 호출
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        var components = URLComponents(string: url)!
        components.queryItems = [URLQueryItem(name: "query", value: search)]
        
        
        let request = URLRequest(url: components.url!)
        
        webView.load(request)
        
        webView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.webView.alpha = 1
        })
    }
    
    func setLayout(){
//        view.addSubview(webViewGroup)
        view.addSubview(webView)
//        webViewGroup.addSubview(webView)
//
//        webViewGroup.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
        webView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}

extension WebViewController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler{
    //도메인체크
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("\(navigationAction.request.url?.absoluteString ?? "")" )
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
    }
}
