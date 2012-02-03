import QtQuick 1.1
import com.nokia.meego 1.0
import cz.vutbr.fit.pcmlich 1.0

PageStackWindow {
    id: appWindow

//    initialPage: testPage

    initialPage: mainPage;



    MainPage {
        id: mainPage

        onShowConfiguration: {
            pageStack.push(configPage)
        }

        onShowEnroled: {
            pageStack.push(enroledPage)
        }
        onShowNews: {
            pageStack.push(newsPage)
        }
        onShowTests: {
            pageStack.push(testListPage)
        }
    }

    EnroledPage {
        id: enroledPage

        onCourseSelected: {
            coursePage.title = title;
            coursePage.abbrv = abbrv
            coursePage.type = type;
            coursePage.completion = completion;
            coursePage.points = points;
            coursePage.credits = credits;
            coursePage.upd_ts = upd_ts;
            pageStack.push(coursePage)
        }
        onRefresh: {
            downloader.reload();
        }
        onBack: {
            pageStack.pop();
        }
    }


    ConfigPage {
        login: downloader.login;
        password: downloader.password;



        id: configPage;
        onSave: {
            downloader.login = login;
            downloader.password = password;
            downloader.reload()
            pageStack.pop()
        }
    }

    CoursePage {
        id: coursePage;
        onBack: {
            pageStack.pop();
        }
    }

    NewsPage {
        id: newsPage
        onBack: {
            pageStack.pop();
        }
    }

    TestListPage {
        id: testListPage;
        onTestSelected: {
            testPage.testName = filename
            pageStack.push(testPage)
        }
        onBack: {
            pageStack.pop();
        }
    }


    Downloader {
        id: downloader;
        onResponseChanged: {
            enroledPage.model.xml = response;
        }
        onErrorMessageChanged: {
            enroledPage.errorString = errorMessage;

        }

        onDownloadStarted: {
            enroledPage.loading = true;
        }
        onDownloadFinished: {
            enroledPage.loading = false;
        }
    }

    Component.onCompleted:  {
        downloader.reload();
    }


    TestPage {
        id: testPage;
        onBack: {
            pageStack.pop();
        }
    }


}
