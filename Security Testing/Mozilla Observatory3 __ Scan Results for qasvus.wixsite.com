<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="{{ AUTHOR }}">
    <meta name="description" content="The Mozilla Observatory is a project designed to help developers, system administrators, and security professionals configure their sites safely and securely.">
    <meta property="og:title" content="Mozilla Observatory">

    <!-- favicon stuff -->
    <link rel="apple-touch-icon" type="image/png" sizes="180x180" href="/images/favicons/apple-touch-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="196x196" href="/images/favicons/favicon-196x196.png">
    <link rel="shortcut icon" href="/images/favicons/favicon.ico">

    <title>Mozilla Observatory</title>
<link href="../2e0dbb1d886e2ee1ed7c.index.css" rel="stylesheet" integrity="sha256-6bRUgjTfZfbsZ5/XQ75qgp1qcb2rrfhSFA1WJVfoeAc=" crossorigin="anonymous"></head>
<body>
    <header class="mb-0 mb-md-3">
        <div class="alert alert-danger text-center" id="scoring-banner">
            📣︎ Heads up! New security scoring standards apply - Your website grade may have changed. MDN Observatory will launch soon.
            <a href="https://developer.mozilla.org/en-US/blog/mdn-observatory/" target="_blank">Learn More</a>.
        </div>
        <div class="container">
            <nav class="navbar navbar-expand-lg navbar-primary bg-white">
              <a class="navbar-brand" href="/"><img id="observatory-wordmark" src="/images/observatory-wordmark.svg" alt="Observatory by Mozilla"></a>
              <button class="navbar-toggler" type="button" data-octicon="grabber" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              </button>

              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                  <li class="nav-item text-right">
                    <a class="nav-link" href="/">Home</a>
                  </li>
                  <li class="nav-item text-right">
                    <a class="nav-link" href="/faq/">FAQ</a>
                  </li>
                  <li class="nav-item text-right">
                    <a class="nav-link" href="/statistics/">Statistics</a>
                  </li>
                  <li class="nav-item text-right dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      About
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                      <a class="dropdown-item" href="https://github.com/mozilla/http-observatory/blob/master/httpobs/docs/api.md">API Documentation</a>
                      <a class="dropdown-item" href="https://github.com/mozilla/http-observatory-website/">Contribute at GitHub</a>
                      <a class="dropdown-item" href="/faq/">Frequently Asked Questions</a>
                      <a class="dropdown-item" href="/terms/">Legal &amp; Privacy</a>
                      <a class="dropdown-item" href="https://github.com/mozilla/http-observatory/blob/master/httpobs/docs/scoring.md">Scoring Methodology</a>
                    </div>
                  </li>
                </ul>
              </div>
            </nav>
        </div>
    </header>

    <!-- main content -->
    <div class="container mb-3">

    <nav>
        <div id="nav-tab" class="nav nav-tabs flex-column flex-md-row" role="tablist">
            <a class="nav-item nav-link active" id="nav-http-tab" href="#http" data-toggle="tab" data-target="#http-tab" role="tab" aria-controls="nav-http" aria-selected="true"><span data-octicon="chevron-right"> </span>HTTP Observatory</a>
            <a class="nav-item nav-link" id="nav-tls-tab" href="#tls" data-toggle="tab" data-target="#tls-tab" role="tab" aria-controls="nav-tls"><span data-octicon="chevron-right"> </span>TLS Observatory</a>
            <a class="nav-item nav-link" id="nav-ssh-tab" href="#ssh" data-toggle="tab" data-target="#ssh-tab" role="tab" aria-controls="nav-ssh"><span data-octicon="chevron-right"> </span>SSH Observatory</a>
            <a class="nav-item nav-link" id="nav-third-party-tab" href="#third-party" data-toggle="tab" data-target="#third-party-tab" role="tab" aria-controls="nav-third"><span data-octicon="chevron-right"> </span>Third-party Tests</a>
        </div>
    </nav>

    <div class="tab-content">
        <!-- HTTP Observatory -->
        <div class="tab-pane active" id="http-tab" role="tabpanel" aria-labelledby="nav-http-tab">
            <!-- progress bar -->
            <div id="http-progress">
    <div class="card card-primary">
        <div class="card-header bg-primary text-white">
            <span class="h3">Scan Summary</span>
        </div>

        <div class="row">
            <div class="col-xs-12 col-md-8 offset-md-2">
                <div id="http-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
                    <div id="http-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
                        Loading Results
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


            <div class="d-none alert alert-danger text-center" id="http-status-code-alert">
                This site returned an HTTP status code other than <strong>200 (OK)</strong>, which may cause its results to be inaccurate.
            </div>

            <div class="d-none" id="http-results">
                <div id="scan-summary-row" class="row">
                    <div class="col-xs-12 col-lg-6">
                        <div class="card card-primary summary summary-condensed" id="scan-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Scan Summary</span>
    </div>
    <div class="card-body pb-1">
        <div class="row">
            <div class="col-xs-12 col-xl-4 mb-3 text-center">
                <span class="grade-container text-center" id="scan-grade-container">
                    <span class="grade-letter" id="scan-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="scan-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-xl-8 pl-xl-0 table-responsive">
                <table class="table table-striped table-sm scan-summary-table">
                    <tr>
                        <td class="text-nowrap">Host:</td>
                        <td class="text-break"><span class="d-none" id="scan-target-container"><span id="scan-target"></span> &rarr; </span><span id="scan-hostname"></span></td>
                    </tr>
                    <tr>
                        <td class="text-nowrap">Scan ID #:</td>
                        <td><span id="scan-scan_id"></span></td>
                    </tr>
                    <tr>
                        <td class="text-nowrap">Start Time:</td>
                        <td id="scan-start_time_l"></td>
                    </tr>
                    <tr>
                        <td class="text-nowrap">Duration:</td>
                        <td><span id="scan-test_duration"></span> seconds</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="text-nowrap">Score:</td>
                        <td><span id="scan-score"></span>/100</td>
                    </tr>
                    <tr>
                        <td class="text-nowrap">Tests Passed:</td>
                        <td><span id="scan-tests_passed"></span>/<span id="scan-tests_quantity"></span></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
                    </div>
                    <div class="col-xs-12 col-lg-6">
                        <div class="card card-success summary mt-4 mt-lg-0 h-100 d-inline-block" id="recommended-change">
    <div class="card-header bg-success text-center text-md-left text-white">
        <span class="h3">Recommendation</span>
        <button class="btn bg-white float-right expandy-panel-button disabled d-none d-md-block force-rescan" type="button" data-toggle="popover" title="Made some improvements?" data-content="The HTTP Observatory allows you to scan your site every five minutes.">Initiate Rescan</button>
    </div>
    <div class="card-body pb-0">
        <!-- Next steps -->
        <div class="d-none" id="next-steps">
            <div id="next-steps-cross-origin-resource-sharing" class="d-none">
                <p>Your site is configured with extremely broad resource sharing permissions.</p>
                <p>This can be dangerous, and is possibly not what was intended.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#cross-origin-resource-sharing">Mozilla Web Security Guidelines (cross-origin resource sharing)</a></li>
                    <li><a href="https://pokeinthe.io/2016/11/29/understanding-cors/">Understanding CORS</a></li>
                </ul>
            </div>
            <div id="next-steps-https" class="d-none">
                <p>Wondering where to start?</p>
                <p>Adding HTTPS protects your site's visitors from tracking, malware, and injected advertising.</p>
                <p>Many services providers and certificate authorities now provide free HTTPS and digital certificates to make this as painless as possible!</p>
                <ul>
                    <li><a href="https://wiki.mozilla.org/Security/Server_Side_TLS">Mozilla TLS Guidelines</a></li>
                    <li><a href="https://ssl-config.mozilla.org">Mozilla TLS Configuration Generator</a></li>
                </ul>
            </div>
            <div id="next-steps-redirection" class="d-none">
                <p>We noticed that your site is accessible over HTTPS, but still defaults to HTTP.</p>
                <p>Automatically redirecting from HTTP to HTTPS helps ensure that your users get served a secure version of your site.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#http-redirections">Mozilla Web Security Guidelines (redirections)</a></li>
                    <li><a href="https://ssl-config.mozilla.org">Mozilla TLS Configuration Generator</a></li>
                </ul>
            </div>
            <div id="next-steps-strict-transport-security" class="d-none">
                <p>Fantastic work using HTTPS! Did you know that you can ensure users never visit your site over HTTP accidentally?</p>
                <p>HTTP Strict Transport Security tells web browsers to only access your site over HTTPS in the future, even if the user attempts to visit over HTTP or clicks an <code>http://</code> link.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security">Mozilla Web Security Guidelines (HSTS)</a></li>
                    <li><a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security">MDN on HTTP Strict Transport Security</a></li>
                </ul>
            </div>
            <div id="next-steps-cookies" class="d-none">
                <p>You're doing a great job with HTTPS and HTTP Strict Transport Security!</p>
                <p>Since you’re now only allowing connections over HTTPS, consider using the <code>Secure</code> flag to protect your cookies against their accidental transmission over HTTP. Furthermore, the use of <code>HttpOnly</code> protects your session cookies from malicious JavaScript.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#cookies">Mozilla Web Security Guidelines (cookies)</a></li>
                </ul>
            </div>
            <div id="next-steps-x-frame-options" class="d-none">
                <p>What’s a good next step?</p>
                <p>The use of the <code>X-Frame-Options</code> header and Content Security Policy’s <code>frame-ancestors</code> directive are a simple and easy way to protect your site against clickjacking attacks.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#x-frame-options">Mozilla Web Security Guidelines (X-Frame-Options)</a></li>
                </ul>
            </div>
            <div id="next-steps-x-content-type-options" class="d-none">
                <p>You’re halfway finished! Nice job!</p>
                <p>The <code>X-Content-Type-Options</code> header tells browsers to stop automatically detecting the contents of files. This protects against attacks where they're tricked into incorrectly interpreting files as JavaScript.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#x-content-type-options">Mozilla Web Security Guidelines (X-Content-Type-Options)</a></li>
                </ul>
            </div>
            <div id="next-steps-content-security-policy" class="d-none">
                <p>You’re doing a wonderful job so far!</p>
                <p>Did you know that a strong Content Security Policy (CSP) policy can help protect your website against malicious cross-site scripting attacks?</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#content-security-policy">Mozilla Web Security Guidelines (Content Security Policy)</a></li>
                    <li><a href="https://www.html5rocks.com/en/tutorials/security/content-security-policy/">An Introduction to Content Security Policy</a></li>
                    <li><a class="google-csp-evaluator-link" href="https://csp-evaluator.withgoogle.com/">Google CSP Evaluator</a></li>
                    <li><a href="https://addons.mozilla.org/en-US/firefox/addon/laboratory-by-mozilla/">Mozilla Laboratory CSP Generator</a></li>
                </ul>
            </div>
            <div id="next-steps-subresource-integrity" class="d-none">
                <p>We’ve noticed you’re using other domains to host your JavaScript code.</p>
                <p>Subresource Integrity guarantees that your site will stay safe even if one of those domains is compromised.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#subresource-integrity">Mozilla Web Security Guidelines (Subresource Integrity)</a></li>
                    <li><a href="https://www.srihash.org/">SRI Hash Generator</a></li>
                </ul>
            </div>
            <div id="next-steps-referrer-policy" class="d-none">
                <p>You’re on the home stretch!</p>
                <p>The use of Referrer Policy can help protect the privacy of your users by restricting the information that browsers provide when accessing resources kept on other sites.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#referrer-policy">Mozilla Web Security Guidelines (Referrer Policy)</a></li>
                </ul>
            </div>
            <div id="next-steps-content-security-policy-unsafe-inline-in-style-src-only" class="d-none">
                <p>Almost there!</p>
                <p>Your current CSP policy allows the use of <code>'unsafe-inline'</code> inside of <code>style-src</code>. Moving <code>style</code> attributes into external stylesheets not only makes you safer, but also makes your code easier to maintain.</p>
                <ul>
                    <li><a href="https://infosec.mozilla.org/guidelines/web_security#content-security-policy">Mozilla Web Security Guidelines (Content Security Policy)</a></li>
                    <li><a href="https://www.html5rocks.com/en/tutorials/security/content-security-policy/">An Introduction to Content Security Policy</a></li>
                    <li><a class="google-csp-evaluator-link" href="https://csp-evaluator.withgoogle.com/">Google CSP Evaluator</a></li>
                </ul>
            </div>
            <div id="next-steps-congratulations" class="d-none">
                <p class="text-center"><em>&#x1F389;&#x1F389;&#x1F389;&nbsp; We don't have any! &nbsp;&#x1F389;&#x1F389;&#x1F389;</em></p>
                <hr>
                <p>Make sure to check back occasionally to ensure that your website is keeping up with the latest in web security standards.</p>
                <p>In the meantime, thanks for everything you're doing to keep the internet a safe, secure, and private place!</p>
            </div>
            <div id="next-steps-initiate-rescan">
                <hr>
                <p>Once you've successfully completed your change, click Initiate Rescan for the next piece of advice.</p>
            </div>
        </div>
    </div>
</div>

                    </div>
                </div>

                <!-- this is a spacing div because recommendation uses h-100, which mucks up padding -->
                <div class="d-lg-none pb-4"></div>

                <!-- HTTP Observatory test results -->
                <!-- HTTP Observatory test results -->
<div class="card card-primary mt-4" id="test-scores">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Test Scores</span>
    </div>
    <div class="card-body pb-0 pt-1">
        <table id="test-scores-table" class="table tablesaw table-striped" data-tablesaw-mode="stack" data-tablesaw-hide-empty>
            <thead>
                <tr>
                    <th scope="col">Test</th>
                    <th scope="col">Pass</th>
                    <th scope="col">Score</th>
                    <th scope="col">Reason</th>
                    <th class="tablesaw-hideable" scope="col">Info</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#content-security-policy">Content Security Policy</a></td>
                    <td class="tablesaw-center" id="tests-content-security-policy-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-content-security-policy-score"></td>
                    <td id="tests-content-security-policy-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Content Security Policy" data-content="Content Security Policy (CSP) can prevent a wide range of cross-site scripting (XSS) and clickjacking attacks against your website."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#cookies">Cookies</a></td>
                    <td class="tablesaw-center" id="tests-cookies-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-cookies-score"></td>
                    <td id="tests-cookies-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Cookies" data-content="Using cookies attributes such as Secure and HttpOnly can protect users from having their personal information stolen."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#cross-origin-resource-sharing">Cross-origin Resource Sharing</a></td>
                    <td class="tablesaw-center" id="tests-cross-origin-resource-sharing-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-cross-origin-resource-sharing-score"></td>
                    <td id="tests-cross-origin-resource-sharing-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Cross-origin Resource Sharing" data-content="Incorrectly configured CORS settings can allow foreign sites to read your site's contents, possibly allowing them access to private user information."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security">HTTP Strict Transport Security</a></td>
                    <td class="tablesaw-center" id="tests-strict-transport-security-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-strict-transport-security-score"></td>
                    <td id="tests-strict-transport-security-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="HTTP Strict Transport Security" data-content="HTTP Strict Transport Security (HSTS) instructs web browsers to visit your site only over HTTPS."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#http-redirections">Redirection</a></td>
                    <td class="tablesaw-center" id="tests-redirection-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-redirection-score"></td>
                    <td id="tests-redirection-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Redirection" data-content="Properly configured redirections from HTTP to HTTPS allow browsers to correctly apply HTTP Strict Transport Security (HSTS) settings."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#referrer-policy">Referrer Policy</a></td>
                    <td class="tablesaw-center" id="tests-referrer-policy-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-referrer-policy-score"></td>
                    <td id="tests-referrer-policy-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Referrer Policy" data-content="Referrer Policy can protect the privacy of your users by restricting the contents of the HTTP Referer header."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#subresource-integrity">Subresource Integrity</a></td>
                    <td class="tablesaw-center" id="tests-subresource-integrity-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-subresource-integrity-score"></td>
                    <td id="tests-subresource-integrity-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Subresource Integrity" data-content="Subresource Integrity protects against JavaScript files and stylesheets stored on content delivery networks (CDNs) from being maliciously modified."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#x-content-type-options">X-Content-Type-Options</a></td>
                    <td class="tablesaw-center" id="tests-x-content-type-options-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-x-content-type-options-score"></td>
                    <td id="tests-x-content-type-options-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="X-Content-Type-Options" data-content="X-Content-Type-Options instructs browsers to not guess the MIME types of files that the web server is delivering."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#x-frame-options">X-Frame-Options</a></td>
                    <td class="tablesaw-center" id="tests-x-frame-options-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-x-frame-options-score"></td>
                    <td id="tests-x-frame-options-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="X-Frame-Options" data-content="X-Frame-Options controls whether your site can be framed, protecting against clickjacking attacks. It has been superseded by Content Security Policy's <code>frame-ancestors</code> directive, but should still be used for now."></span></td>
                </tr>
                <tr>
                    <td class="title font-weight-bold tablesaw-nowrap"><a href="https://infosec.mozilla.org/guidelines/web_security#x-xss-protection">X-XSS-Protection</a></td>
                    <td class="tablesaw-center" id="tests-x-xss-protection-pass" aria-hidden="true"></td>
                    <td class="tablesaw-center" id="tests-x-xss-protection-score"></td>
                    <td id="tests-x-xss-protection-score-description"></td>
                    <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="X-XSS-Protection" data-content="X-XSS-Protection protects against reflected cross-site scripting (XSS) attacks in IE and Chrome, but has been superseded by Content Security Policy. It can still be used to protect users of older web browsers."></span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

                <!-- HTTP Observatory CSP analysis -->
                <!-- HTTP Observatory CSP analysis -->
<div class="card card-primary d-none mt-4" id="csp-analysis">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3 d-none d-md-inline">Content Security Policy Analysis</span>
        <span class="h3 d-md-none">CSP Analysis</span>
    </div>
    <div class="card-body pb-0 pt-1" id="csp-analysis-panel-body">
        <div class="table-responsive">
            <table id="csp-analysis-table" class="table table-striped">
                <thead>
                    <tr>
                        <th scope="column">Test</th>
                        <th scope="column">Pass</th>
                        <th class="tablesaw-hideable" scope="column">Info</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="title">Blocks execution of inline JavaScript by not allowing <code>'unsafe-inline'</code> inside <code>script-src</code></td>
                        <td class="tablesaw-center" id="csp-analysis-unsafeInline" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Unsafe Inline JavaScript" data-content="Blocking the execution of inline JavaScript provides CSP's strongest protection against cross-site scripting attacks.<br><br>Moving JavaScript to external files can also help make your site more maintainable."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Blocks execution of JavaScript's <code>eval()</code> function by not allowing <code>'unsafe-eval'</code> inside <code>script-src</code></td>
                        <td class="tablesaw-center" id="csp-analysis-unsafeEval" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Unsafe JavaScript eval()" data-content="Blocking the use of JavaScript's <code>eval()</code> function can help prevent the execution of untrusted code."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Blocks execution of plug-ins, using <code>object-src</code> restrictions</td>
                        <td class="tablesaw-center" id="csp-analysis-unsafeObjects" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Blocking plug-ins" data-content="Blocking the execution of plug-ins via <code>object-src 'none'</code> or as inherited from <code>default-src</code> can prevent attackers from loading Flash or Java in the context of your page."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Blocks inline styles by not allowing <code>'unsafe-inline'</code> inside <code>style-src</code></td>
                        <td class="tablesaw-center" id="csp-analysis-unsafeInlineStyle" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Unsafe Inline Styles" data-content="Blocking inline styles can help prevent attackers from modifying the contents or appearance of your page.<br><br>Moving styles to external stylesheets can also help make your site more maintainable."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Blocks loading of active content over HTTP or FTP</td>
                        <td class="tablesaw-center" id="csp-analysis-insecureSchemeActive" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Insecure Active Resources" data-content="Loading JavaScript or plugins can allow a man-in-the-middle to execute arbitrary code or your website. Restricting your policy and changing links to HTTPS can help prevent this."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Blocks loading of passive content over HTTP or FTP</td>
                        <td class="tablesaw-center" id="csp-analysis-insecureSchemePassive" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Insecure Passive Resources" data-content="This site's Content Security Policy allows the loading of passive content such as images or videos over insecure protocols such as HTTP or FTP. Consider changing them to load them over HTTPS."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Clickjacking protection, using <code>frame-ancestors</code></td>
                        <td class="tablesaw-center" id="csp-analysis-antiClickjacking" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Clickingjacking Protection" data-content="The use of CSP's <code>frame-ancestors</code> directive offers fine-grained control over who can frame your site."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Deny by default, using <code>default-src 'none'</code></td>
                        <td class="tablesaw-center" id="csp-analysis-defaultNone" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Deny by Default" data-content="Denying by default using <code>default-src 'none'</code>can ensure that your Content Security Policy doesn't allow the loading of resources you didn't intend to allow."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Restricts use of the <code>&lt;base&gt;</code> tag by using <code>base-uri 'none'</code>, <code>base-uri 'self'</code>, or specific origins</td>
                        <td class="tablesaw-center" id="csp-analysis-insecureBaseUri" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Restricts <code>base</code> tag" data-content="The <code>base</code> tag can be used to trick your site into loading scripts from untrusted origins."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Restricts where <code>&lt;form&gt;</code> contents may be submitted by using <code>form-action 'none'</code>, <code>form-action 'self'</code>, or specific URIs</td>
                        <td class="tablesaw-center" id="csp-analysis-insecureFormAction" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Restricts form submissions" data-content="Malicious JavaScript or content injection could modify where sensitive form data is submitted to or create additional forms for data exfiltration."></span></td>
                    </tr>
                    <tr>
                        <td class="title">Uses CSP3's <code>'strict-dynamic'</code> directive to allow dynamic script loading (optional)</td>
                        <td class="tablesaw-center" id="csp-analysis-strictDynamic" aria-hidden="true"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span data-octicon="info" data-toggle="popover" title="Strict Dynamic" data-content="<code>'strict-dynamic'</code> lets you use a JavaScript shim loader to load all your site's JavaScript dynamically, without having to track <code>script-src</code> origins."></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div>
        <p class="text-center"><a class="btn btn-primary google-csp-evaluator-link mx-4" href="https://csp-evaluator.withgoogle.com/">Looking for additional help? Check out Google's CSP Evaluator!</a></p>
    </div>
</div>

                <!-- HTTP Observatory cookie results -->
                <!-- HTTP Observatory cookie results -->
<div class="card mt-4 d-none" id="cookies">
    <div class="card-header bg-primary text-white">
        <span class="h3">Cookies</span>
    </div>
    <div class="card-body pb-0 pt-1" id="cookies-panel-body">
        <div class="table-responsive">
            <table class="table tablesaw table-striped" id="cookies-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty>
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Expires</th>
                        <th class="tablesaw-center">Path</th>
                        <th class="tablesaw-center"><abbr title="Secure" data-toggle="popover" data-content="Setting the <code>Secure</code> attribute on cookies will prevent them from being sent over insecure HTTP.">Secure</abbr></th>
                        <th class="tablesaw-center"><abbr title="HttpOnly" data-toggle="popover" data-content="<code>HttpOnly</code> cookies are inaccessible from JavaScript, preventing cross-site scripting (XSS) attacks from stealing session cookies.">HttpOnly</abbr></th>
                        <th class="tablesaw-center"><abbr title="SameSite" data-toggle="popover" data-content="The <code>SameSite</code> attribute prevents your cookies from being sent cross-site, protecting against CSRF attacks.">SameSite</abbr></th>
                        <th class="tablesaw-center"><abbr title="Prefixed" data-toggle="popover" data-content="Using the <code>__Host-</code> and <code>__Secure-</code> prefixes on cookie names prevents them from being overwritten by insecure origins.">Prefixed</abbr></th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

                <!-- HTTP Observatory grade history results -->
                <!-- HTTP Observatory host history results d-none d-md-block-->
<div class="card  mt-4" id="host-history">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Grade History</span>
        <button class="btn btn-default bg-white float-right expandy-panel-button" type="button" data-toggle="collapse" data-target="#host-history-panel-body" aria-expanded="false" aria-controls="host-history-panel-body">Click to View</button>
    </div>
    <div class="card-body collapse pb-0 pt-1" id="host-history-panel-body">
        <table class="table tablesaw table-striped" id="host-history-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty>
            <thead>
                <tr>
                    <th scope="col">Date</th>
                    <th class="tablesaw-center" scope="col">Score</th>
                    <th class="tablesaw-center" scope="col">Grade</th>
                </tr>
            </thead>
        </table>
    </div>
</div>

                <!-- HTTP Observatory raw header test results -->
                <!-- HTTP Observatory raw header test results -->
<div class="card mt-4" id="server-headers">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Raw Server Headers</span>
    </div>
    <div class="card-body pb-0 pt-1" id="server-headers-card-body">
        <table class="table tablesaw table-striped colon-ized" id="server-headers-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty>
            <thead>
                <th>Header</th>
                <th>Value</th>
            </thead>
        </table>
    </div>
</div>

            </div>
        </div>

        <!-- TLS Observatory -->
        <div class="tab-pane" id="tls-tab" role="tabpanel" aria-labelled-by="nav-tls-tab">
            <!-- progress bar -->
            <div id="tls-progress">
    <div class="card card-primary">
        <div class="card-header bg-primary text-white">
            <span class="h3">Scan Summary</span>
        </div>

        <div class="row">
            <div class="col-xs-12 col-md-8 offset-md-2">
                <div id="tls-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
                    <div id="tls-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
                        Loading Results
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


            <div class="d-none" id="tls-results">
                <!-- invalid cert warning panel -->
                <div class="d-none alert alert-danger text-md-center" id="tls-observatory-invalid-cert-warning">
                    This site uses an <strong>untrusted</strong> or <strong>invalid certificate</strong>. The following results ignore this error.
                </div>

                <!-- TLS Observatory scan summary -->
                <div class="card card-primary" id="tls-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Scan Summary</span>
    </div>

    <div class="card-body pb-1">
        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="tls-summary-grade-container">
                    <span class="grade-letter" id="tls-summary-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="tls-summary-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10 table-responsive">
                <table class="table table-striped table-sm summary">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break"><span id="tls-summary-target"></span> <span class="deemphasize">(<span id="tls-summary-ip"></span>)</span></td>
                    </tr>
                    <tr>
                        <td>Scan ID #:</td>
                        <td id="tls-summary-scan_id"></td>
                    </tr>
                    <tr>
                        <td>End Time:</td>
                        <td id="tls-summary-end_time_l"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <a class="d-none d-md-inline text-nowrap" href="https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_configurations">Compatibility Level:</a>
                            <a class="d-md-none" href="https://wiki.mozilla.org/Security/Server_Side_TLS#Recommended_configurations">Compat. Level:</a>
                        </td>
                        <td class="text-prewrap" id="tls-summary-mozilla_configuration_level_description"></td>
                    </tr>
                    <!--
                    <tr>
                        <td>Score:</td>
                        <td><span id="tls-summary-score"></span>/100</td>
                    </tr>
                    -->
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>
                        <span class="d-none d-md-inline text-nowrap">Certificate Explainer:</span>
                        <span class="d-md-none">Explainer:</span>
                      </td>
                      <td class="text-break" id="tls-summary-explainer_url"></td>
                    </tr>
                    <!--
                    <tr>
                        <td>Certificate Results (JSON):</td>
                        <td id="tls-summary-certificate_url"></td>
                    </tr>
                    <tr>
                        <td>Scan Results (JSON):</td>
                        <td id="tls-summary-results_url"></td>
                    </tr>
                    -->
                </table>
            </div>
        </div>
    </div>
</div>

                <!-- TLS Observatory certificate information -->
                <!-- TLS Observatory certificate panel -->
<div class="card card-primary mt-4" id="tls-certificate">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3 d-none d-md-inline">Certificate Information</span>
        <span class="h3 d-md-none">Certificate</span>
    </div>
    <div class="card-body pb-0">
        <div class="table-responsive">
            <table class="table tablesaw table-striped scan-summary-table" id="tls-certificate-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty data-tablesaw-no-labels>
                <thead class="d-none">
                    <th></th>
                    <th></th>
                </thead>
                <tbody>
                    <tr>
                        <td>Common name:</td>
                        <td id="tls-certificate-cn"></td>
                    </tr>
                    <tr>
                        <td>Alternative Names:</td>
                        <td id="tls-certificate-alt_names"></td>
                    </tr>
                    <tr class="tablesaw-hideable">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>First Observed:</td>
                        <td><span id="tls-certificate-first_seen"></span><span class="deemphasize"> (certificate #<span id="tls-certificate-cert_id"></span>)</span></td>
                    </tr>
                    <tr class="tablesaw-hideable">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Valid From:</td>
                        <td id="tls-certificate-valid_from"></td>
                    </tr>
                    <tr>
                        <td>Valid To:</td>
                        <td id="tls-certificate-valid_to"></td>
                    </tr>
                    <tr class="tablesaw-hideable">
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Key:</td>
                        <td id="tls-certificate-key"></td>
                    </tr>
                    <tr>
                        <td>Issuer:</td>
                        <td id="tls-certificate-issuer"></td>
                    </tr>
                    <tr>
                        <td>Signature Algorithm:</td>
                        <td id="tls-certificate-sig_alg"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

                <!-- TLS Observatory cipher suites -->
                <!-- TLS Observatory protocol panel -->
<div class="card card-primary mt-4" id="tls-ciphers">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Cipher Suites</span>
    </div>
    <div class="card-body pb-0 pt-1">
        <div class="table-responsive">
            <table class="table tablesaw table-striped" id="tls-ciphers-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty>
                <thead>
                    <tr>
                        <th><span class="d-none d-md-inline">Cipher Suite</span><span class="d-md-none">Cipher</span></th>
                        <th class="tablesaw-center"><abbr title="Code Points" data-toggle="popover" data-content="Cipher suite names can vary between implementation. Code points are a standardized set of numbers that allow you to refer to a specific cipher suite regardless of implementation.">Code</abbr></th>
                        <th class="tablesaw-center"><span class="d-none d-md-inline">Key size</span><span class="d-md-none">Size</span></th>
                        <th class="tablesaw-center"><abbr title="Authenticated Encryption with Associated Data" data-toggle="popover" data-content="AEADs are a new way of using cryptographic ciphers that provide additional security guarantees while being less prone to implementation mistakes.">AEAD</abbr></th>
                        <th class="tablesaw-center"><abbr title="Forward Secrecy" data-toggle="popover" data-content="Forward secrecy protects your past communications from being decrypted if the server's private key is ever compromised.">PFS</abbr></th>
                        <th>Protocols</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</div>

                <!-- TLS Observatory miscellaneous -->
                <!-- TLS Observatory misc panel -->
<div class="card card-primary mt-4" id="tls-misc">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3 d-none d-md-inline">Miscellaneous Information</span>
        <span class="h3 d-md-none">Miscellaneous</span>
    </div>
    <div class="card-body pb-0">
        <div class="table-responsive">
            <table class="table tablesaw table-striped scan-summary-table" id="tls-misc-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty data-tablesaw-no-labels>
                <thead class="d-none">
                    <th></th>
                    <th></th>
                    <th></th>
                </thead>
                <tbody>
                    <tr>
                        <td>CAA Record:</td>
                        <td id="tls-misc-caa"></td>
                        <td class="tablesaw-hideable" data-octicon="info" data-toggle="popover" title="Certification Authority Authorization" data-content="Certification Authority Authorization (CAA) records inform certificate authorities whether or not they are allowed to issue certificates for your domain."></td>
                    </tr>
                    <tr>
                        <td>Cipher Preference:</td>
                        <td><span id="tls-misc-chooser"></span> selects preferred cipher</td>
                        <td class="tablesaw-hideable" data-octicon="info" data-toggle="popover" title="Cipher Preference" data-content="Configuring your server to choose the preferred cipher can force older clients to use more secure ciphers than they would by default."></td>
                    </tr>
                    <tr id="tls-misc-oldest_clients-row">
                        <td>Compatible Clients:</td>
                        <td id="tls-misc-oldest_clients"></td>
                        <td class="tablesaw-hideable"></td>
                    </tr>
                    <tr>
                        <td>OCSP Stapling:</td>
                        <td id="tls-misc-ocsp_stapling"></td>
                        <td class="tablesaw-hideable" data-octicon="info" data-toggle="popover" title="OCSP Stapling" data-content="OCSP Stapling allows clients to check for certificate revocation both quickly and privately."></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

                <!-- TLS Observatory suggestions -->
                <!-- TLS Observatory suggestions panel -->
<div class="card card-primary mt-4" id="tls-suggestions">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Suggestions</span>
    </div>
    <div class="card-body" id="tls-suggestions-panel-body">
        <div id="tls-suggestions-modern-row">
            <p><strong>Looking for improved security and have a user base of only modern clients?</strong></p>
            <p class="pl-2 pr-1" id="tls-suggestions-modern-notes">Take a look at the <a href="https://wiki.mozilla.org/Security/Server_Side_TLS#Modern_compatibility">Mozilla &ldquo;Modern&rdquo; TLS configuration</a>!  It provides an extremely high level of security and performance and is compatible with all clients released in the last couple years. It is not recommended for general purpose websites that may need to service older clients such as Android 4.x, Internet Explorer 10, or Java 6.x.</p>
            <p class="text-right"><a role="button" data-toggle="collapse" href="#tlsobservatory-suggestions-modern" aria-expanded="false" aria-controls="tls-suggestions-modern">Want the detailed technical nitty-gritty?</a></p>
            <p class="pl-2 pr-1 collapse" id="tls-suggestions-modern"></p>
        </div>
        <div id="tls-suggestions-intermediate-row">
            <hr>
            <p><strong>Still want secure website, but need compatibility with those older clients?</strong></p>
            <p class="pl-2 pr-1" id="tls-suggestions-intermediate-notes">No problem! The <a href="https://wiki.mozilla.org/Security/Server_Side_TLS#Intermediate_compatibility_.28default.29">Mozilla &ldquo;Intermediate&rdquo; TLS configuration</a> may be just right for you!  It provides the similar level of security to the &ldquo;Modern&rdquo; configuration when used with current clients, but still supports older versions of web browsers and tools.</p>
            <p class="text-right"><a role="button" data-toggle="collapse" href="#tlsobservatory-suggestions-intermediate" aria-expanded="false" aria-controls="tls-suggestions-intermediate">Want the detailed technical nitty-gritty?</a></p>
            <p class="pl-2 pr-1 collapse" id="tls-suggestions-intermediate"></p>
        </div>
        <hr>
        <div id="tls-suggestions-disclaimer">
            <p>Please note that these suggestions may not be appropriate for your particular usage requirements!  If they do sound like something you'd like assistance with, then hop on board:</p>
            <p class="text-center"><a class="btn btn-primary" href="https://ssl-config.mozilla.org">Teleport me to Mozilla's configuration generator!</a></p>
        </div>
    </div>
</div>
            </div>
        </div>

        <!-- SSH Observatory -->
        <div class="tab-pane" id="ssh-tab" role="tabpanel" aria-labelledby="nav-ssh-tab">
            <div id="ssh-scan-initiator" class="mt-3">
                <button class="btn btn-light expandy-panel-button align-middle py-3 w-100" id="ssh-scan-initiator-btn" type="button">
                  SSH Observatory scans are not performed automatically. Click here to initiate a scan.
                </button>
            </div>

            <!-- Notice about which system hosts the scans -->
            <div class="alert alert-danger d-none mt-3 mx-3 px-3 py-3 rounded" id="ssh-scanner-alert" role="alert">
              <div class="pb-3"><strong>Scan Failed: </strong>The Mozilla SSH Observatory scans from <code class="bg-light mb-3 px-1 py-1 rounded">sshscan.rubidus.com</code> at <code class="bg-light px-1 py-1 rounded">45.55.176.164</code>.</div>

              <div>Many systems are configured with firewalls that block SSH access. To successfully scan with the SSH Observatory, access must be granted to Mozilla's scanning system.</div>
            </div>

            <!-- progress bar -->
            <span id="ssh-progress-bar-container" class="d-none">
                <div id="ssh-progress">
    <div class="card card-primary">
        <div class="card-header bg-primary text-white">
            <span class="h3">Scan Summary</span>
        </div>

        <div class="row">
            <div class="col-xs-12 col-md-8 offset-md-2">
                <div id="ssh-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
                    <div id="ssh-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
                        Loading Results
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

            </span>

            <div class="d-none" id="ssh-results">
                <!-- SSH Observatory scan results -->
                <div class="card card-primary" id="ssh-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Scan Summary</span>
    </div>

    <div class="card-body pb-1">
        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="ssh-grade-container">
                    <span class="grade-letter" id="ssh-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="ssh-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10 table-responsive">
                <table class="table table-striped table-sm summary">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break"><span id="ssh-hostname"></span> <span class="deemphasize">(<span id="ssh-ip"></span>:<span id="ssh-port"></span>)</span></td>
                    </tr>
                    <tr>
                        <td>Scan ID #:</td>
                        <td id="ssh-uuid"></td>
                    </tr>
                    <tr>
                        <td>End Time:</td>
                        <td id="ssh-end_time_l"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><a href="https://infosec.mozilla.org/guidelines/openssh">Mozilla SSH Standards Compliant:</a></td>
                        <td id="ssh-compliant"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

                <!-- SSH Observatory recommendations -->
                <!-- SSH Observatory recommendations panel -->
<div class="card card-success mt-4" id="ssh-recommendations">
    <div class="card-header bg-success text-center text-md-left text-white">
        <span class="h3">Recommendations</span>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped" id="ssh-recommendations-table">
            </table>
        </div>
        <div class="text-center d-none" id="ssh-no-recommendations">
          🎉🎉🎉  <em>We don't have any! Keep up the good work!</em> 🎉🎉🎉
        </div>
    </div>
</div>


                <!-- SSH Observatory miscellaneous -->
                <!-- SSH Observatory miscellaneous panel -->
<div class="card card-primary mt-4" id="ssh-misc">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Miscellaneous</span>
    </div>
    <div class="card-body pb-0">
        <div class="table-responsive">
            <table class="table tablesaw table-striped summary" id="ssh-misc-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty data-tablesaw-no-labels>
                <thead class="d-none">
                    <th scope="column"></th>
                    <th scope="column"></th>
                    <th scope="column" class="tablesaw-hideable"></th>
                </thead>
                <tbody>
                    <tr>
                        <td>Authentication Methods:</td>
                        <td id="ssh-auth_methods"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span class="octicon" data-octicon="info" data-toggle="popover" title="Authentication Methods" data-content="We recommend disabling authentication based solely upon passwords and instead using public key authentication alone or in combination with other authentication methods."></span></td>
                    </tr>
                    <tr>
                        <td>Compression:</td>
                        <td id="ssh-compression"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span class="octicon" data-octicon="info" data-toggle="popover" title="Compression" data-content="Allowing compression can improve data transmission speeds over slow or high latency connections."></span></td>
                    </tr>
                    <tr>
                        <td>Duplicate Host Keys:</td>
                        <td id="ssh-duplicate_host_keys"></td>
                        <td class="tablesaw-hideable tablesaw-center"><span class="octicon" data-octicon="info" data-toggle="popover" title="Duplicate Host Keys" data-content="Using the same host key on multiple machines can be dangerous. If one machine gets compromised, it can impersonate other systems using the same key."></span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


                <!-- SSH Observatory version information -->
                <!-- SSH Observatory version information panel -->
<div class="card card-primary mt-4" id="ssh-version">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Version Information</span>
    </div>
    <div class="card-body pb-0">
        <div class="table-responsive">
            <table class="table tablesaw table-striped summary" id="ssh-version-table" data-tablesaw-mode="stack" data-tablesaw-hide-empty data-tablesaw-no-labels>
                <thead>
                    <th scope="column"></th>
                    <th scope="column"></th>
                </thead>
                <tbody>
                    <tr>
                        <td>Server Banner:</td>
                        <td id="ssh-server_banner"></td>
                    </tr>
                    <tr>
                        <td>Operating System Identifier:</td>
                        <td id="ssh-os_cpe"></td>
                    </tr>
                    <tr>
                        <td>SSH Library Identifier:</td>
                        <td id="ssh-ssh_lib_cpe"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

            </div>
        </div>

        <!-- Third party stuff -->
        <div class="tab-pane" id="third-party-tab" role="tabpanel" aria-labelledby="nav-third-party-tab">
            <h3 class="mt-4 mt-sm-3">
              <span class="d-none d-md-inline">Email Security</span>
              <span class="d-md-none"></span>
            </h3>
            <hr />

            <!-- GCA -->
            <div class="card card-primary mt-4" id="gca-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">Global Cyber Alliance (GCA)</span>
    </div>

    <div class="card-body">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="gca-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="gca-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="gca-grade-container">
                    <span class="grade-letter" id="gca-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="gca-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10 table-responsive summary">
                <table class="table table-striped table-condensed pull-left gca-summary-table">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break" id="gca-target"></td>
                    </tr>
                    <tr>
                        <td><a href="https://en.wikipedia.org/wiki/Sender_Policy_Framework">SPF</a> record:</td>
                        <td id="gca-spf_record"></td>
                    </tr>
                    <tr>
                        <td><a href="https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail">DKIM</a> selector:</td>
                        <td id="gca-dkim_selector"></td>
                    </tr>
                    <tr>
                        <td><a href="https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail">DKIM</a> record:</td>
                        <td id="gca-dkim_record"></td>
                    </tr>
                    <tr>
                        <td><a href="https://en.wikipedia.org/wiki/DMARC">DMARC</a> record:</td>
                        <td id="gca-dmarc_record"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Complete Results:</td>
                        <td class="text-break" id="gca-url"></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row text-right">
            <div class="col-xs-0 col-sm-4 col-md-6 col-lg-8 col-xl-9"></div>
            <div class="col-xs-12 col-sm-8 col-md-6 col-lg-4 col-xl-3">
                <img id="qualys-logo" class="w-100" src="/images/gca-logo.svg" alt="GCA Logo">
            </div>
        </div>
    </div>
</div>

            <hr />

            <h3 class="mt-4 mt-sm-3">
              <span class="d-none d-md-inline">Transport Layer Security</span>
              <span class="d-md-none">TLS &amp; SSL</span>
            </h3>
            <hr />
            <!-- Qualys SSL Labs -->
            <div class="card card-primary" id="ssllabs-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">ssllabs.com</span>
    </div>

    <div class="card-body">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="ssllabs-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="ssllabs-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="ssllabs-grade-container">
                    <span class="grade-letter" id="ssllabs-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="ssllabs-grade-modifier"></sup>
                </span>
            </div>

            <div class="col-xs-12 col-md-9 col-lg-10">
                <div class="table-responsive">
                    <table class="table table-striped ssllabs-summary-table summary">
                        <tr>
                            <td>Host:</td>
                            <td class="text-break" id="ssllabs-hostname"></td>
                        </tr>
                        <tr>
                            <td>Complete Results:</td>
                            <td class="text-break" id="ssllabs-url"></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="row text-right">
            <div class="col-xs-0 col-sm-4 col-md-6 col-lg-8 col-xl-9"></div>
            <div class="col-xs-12 col-sm-8 col-md-6 col-lg-4 col-xl-3">
                <img id="qualys-logo" class="w-100" src="/images/qualys-ssl-labs-logo.svg" alt="Qualys Logo">
            </div>
        </div>
    </div>
</div>

            <!-- ImmuniWeb -->
            <div class="card card-primary mt-4" id="immuniweb-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">ImmuniWeb</span>
    </div>

    <div class="card-body">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="immuniweb-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="immuniweb-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="immuniweb-grade-container">
                    <span class="grade-letter" id="immuniweb-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="immuniweb-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10">
                <div class="table-responsive">
                    <table class="table tablesaw table-striped tbridge-summary-table summary" data-tablesaw-mode="stack" data-tablesaw-hide-empty data-tablesaw-no-labels>
                        <thead class="d-none">
                            <th scope="column"></th>
                            <th scope="column"></th>
                        </thead>

                        <tbody>
                            <tr>
                                <td>Host:</td>
                                <td class="text-break"><span id="immuniweb-hostname""></span> <span class="deemphasize">(<span id="immuniweb-ip"></span>)</span></td>
                            </tr>
                            <tr>
                                <td>Score:</td>
                                <td><span id="immuniweb-score"></span>/100</td>
                            </tr>
                            <tr>
                                <td> </td>
                                <td> </td>
                            </tr>
                            <tr>
                                <td class="p-l-3">PCI-DSS:</td>
                                <td id="immuniweb-pci_dss_compliant"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3">HIPAA:</td>
                                <td id="immuniweb-hipaa_compliant"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3">NIST:</td>
                                <td id="immuniweb-nist_compliant"></td>
                            </tr>
                            <tr>
                                <td> </td>
                                <td> </td>
                            </tr>
                            <tr>
                                <td class="p-l-3"><a href="https://drownattack.com/">DROWN:</a></td>
                                <td id="immuniweb-drown"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3"><a href="http://heartbleed.com/">Heartbleed:</a></td>
                                <td id="immuniweb-heartbleed"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3">
                                    Insecure Renego&shy;tiation:
                                </td>
                                <td id="immuniweb-insecure_reneg"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3">
                                    <a href="https://blog.qualys.com/ssllabs/2014/06/13/ssl-pulse-49-vulnerable-to-cve-2014-0224-14-exploitable">
                                        <span class="d-none d-md-inline">OpenSSL ChangeCipherSpec:</span>
                                        <span class="d-md-none">OpenSSL CCS:</span>
                                    </a>
                                </td>
                                <td id="immuniweb-cve_2014_0224"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3"><a href="https://blog.cloudflare.com/yet-another-padding-oracle-in-openssl-cbc-ciphersuites/">OpenSSL Padding Oracle:</a></td>
                                <td id="immuniweb-cve_2016_2107"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3"><a href="https://www.imperialviolet.org/2014/10/14/poodle.html">Poodle (SSLv3):</a></td>
                                <td id="immuniweb-poodle_ssl"></td>
                            </tr>
                            <tr>
                                <td class="p-l-3"><a href="https://www.imperialviolet.org/2014/12/08/poodleagain.html">Poodle (TLS):</a></td>
                                <td id="immuniweb-poodle_tls"></td>
                            </tr>
                            <tr>
                                <td> </td>
                                <td> </td>
                            </tr>
                            <tr>
                                <td>Complete Results:</td>
                                <td class="text-break"><span id="immuniweb-url"></span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="row text-right">
            <div class="col-xs-0 col-sm-5 col-md-8 col-lg-9 col-xl-9"></div>
            <div class="col-xs-12 col-sm-7 col-md-4 col-lg-3 col-xl-3">
                <img id="immuniweb-logo" class="w-100" src="/images/immuniweb-logo.svg" alt="ImmuniWeb Logo">
            </div>
        </div>
    </div>
</div>

            <!-- tls.imirhil.fr -->
            <!-- tls.imirhil.fr -->
<div class="card card-primary mt-4" id="tlsimirhilfr-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">tls.imirhil.fr</span>
    </div>

    <div class="card-body pb-0">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="tlsimirhilfr-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="tlsimirhilfr-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="tlsimirhilfr-grade-container">
                    <span class="grade-letter" id="tlsimirhilfr-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="tlsimirhilfr-grade-modifier"></sup>
                </span>
            </div>

            <div class="col-xs-12 col-md-9 col-lg-10">
                <table class="table table-striped tlsimirhilfr-summary-table summary">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break" id="tlsimirhilfr-hostname"></td>
                    </tr>
                    <tr>
                        <td>IP addresses:</td>
                        <td class="text-break" id="tlsimirhilfr-addresses"></td>
                    </tr>
                    <tr id="tlsimirhilfr-failing_addresses-row">
                        <td>Failing addresses:</td>
                        <td class="text-break" id="tlsimirhilfr-failing_addresses"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Overall score:</td>
                        <td><span id="tlsimirhilfr-overall_score"></span>/100</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Complete Results:</td>
                        <td class="text-break" id="tlsimirhilfr-url"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

            <h3 class="mt-4 mt-sm-3">
              <span class="d-none d-md-inline">HTTP Headers &amp; Content Security</span>
              <span class="d-md-none">HTTP Headers</span>
            </h3>
            <hr />

            <!-- securityheaders.com -->
            <div class="card card-primary" id="securityheaders-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">securityheaders.com</span>
    </div>
    <div class="card-body pb-0">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="securityheaders-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="securityheaders-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="securityheaders-grade-container">
                    <span class="grade-letter" id="securityheaders-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="securityheaders-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10 table-responsive">
                <table class="table table-striped securityheaders-summary-table summary">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break" id="securityheaders-hostname"></td>
                    </tr>
                    <tr>
                        <td>Complete Results:</td>
                        <td class="text-break" id="securityheaders-url"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

            <h3 class="mt-5">Miscellaneous</h3>
            <hr />

            <!-- hstspreload.org -->
            <div class="card card-primary" id="hstspreload-summary">
    <div class="card-header bg-primary text-center text-md-left text-white">
        <span class="h3">hstspreload.org</span>
    </div>
    <div class="card-body pb-0">
        <!-- someday, this should be merged into progress-bar.html -->
<div id="hstspreload-progress-bar" class="progress progress-lg mx-xs-3 mx-sm-3 mx-md-0">
    <div id="hstspreload-progress-bar-text" class="progress-bar progress-bar-lg progress-bar-striped progress-bar-animated w-100" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100">
        Loading Results
    </div>
</div>


        <div class="row">
            <div class="col-xs-12 col-md-3 col-lg-2 mb-3 text-center">
                <span class="grade-container text-center" id="hstspreload-grade-container">
                    <span class="grade-letter" id="hstspreload-grade-letter"></span>
                    <sup class="grade-letter-modifier" id="hstspreload-grade-modifier"></sup>
                </span>
            </div>
            <div class="col-xs-12 col-md-9 col-lg-10 table-responsive summary">
                <table class="table table-striped table-condensed pull-left hstspreload-summary-table">
                    <tr>
                        <td>Host:</td>
                        <td class="text-break" id="hstspreload-target"></td>
                    </tr>
                    <tr>
                        <td>Preloaded:</td>
                        <td id="hstspreload-preloaded"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td id="hstspreload-notes-label">Notes:</td>
                        <td id="hstspreload-notes" class="text-break"></td>
                    </tr>
                    <tr>
                        <td>Complete Results:</td>
                        <td class="text-break" id="hstspreload-url"></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
        </div>
    </div>

    <!-- main content -->
    </div>
<script type="text/javascript" src="../2e0dbb1d886e2ee1ed7c.index.js" integrity="sha256-368u4NEGcTMeVOQHnZQN53kOlk72mdLAehX87Sg8Q0E=" crossorigin="anonymous"></script></body>
</html>

