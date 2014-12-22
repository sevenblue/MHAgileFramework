//
//  MHSSLWebViewController.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/22.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHSSLWebViewController.h"

@interface MHSSLWebViewController ()
{
    NSURLAuthenticationChallenge *_challenge;
    UIWebView *_webView;
    NSURLRequest *_urlRequest;
    BOOL _isNotNeedReRequest;
}
@end

@implementation MHSSLWebViewController

- (void)initData{
    _urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://graph.z.qq.com/moc2/authorize?response_type=code&client_id=200004&redirect_uri=http://www.youku.com&state=testadsadf&display=mobile&g_ut=2"]];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:_urlRequest delegate:self];
    [connection start];
}

- (void)addUI{
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
}

#pragma mark - NSURLConnectionDelegate
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //webview 重新加载请求。
    if (_isNotNeedReRequest == YES) {
        [_webView loadRequest:_urlRequest];
        [connection cancel];
        _isNotNeedReRequest = NO;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    _challenge = challenge;
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"服务器证书"
                                                        message:@"这个网站有一个服务器证书，点击“接受”，继续访问该网站，如果你不确定，请点击“取消”。"
                                                       delegate:self
                                              cancelButtonTitle:@"接受"
                                              otherButtonTitles:@"取消", nil];
    
    [alertView show];
}

#pragma mark - Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    // Accept=0,Cancel=1;
    if(buttonIndex==0){
        NSURLCredential *   credential;
        NSURLProtectionSpace *  protectionSpace;
        SecTrustRef            trust;
        NSString *              host;
        SecCertificateRef      serverCert;
        
        assert(_challenge !=nil);
        protectionSpace = [_challenge protectionSpace];
        assert(protectionSpace != nil);
        trust = [protectionSpace serverTrust];
        assert(trust != NULL);
        credential = [NSURLCredential credentialForTrust:trust];
        assert(credential != nil);
        
        host = [[_challenge protectionSpace] host];
        if (SecTrustGetCertificateCount(trust) > 0) {
            serverCert = SecTrustGetCertificateAtIndex(trust, 0);
        } else {
            serverCert = NULL;
        }
        [[_challenge sender] useCredential:credential forAuthenticationChallenge:_challenge];
        
        _isNotNeedReRequest = YES;
    }else{
        _isNotNeedReRequest = NO;
    }
    
}

#pragma mark -

@end
