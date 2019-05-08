import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin'
// import { Firestore } from '@google-cloud/firestore';
// import { stat } from 'fs';
admin.initializeApp()

// const userInfomation = require('./userInfomation');
// const createNewAuth = require('./createNewAuth');

export const getUserInfo = 
functions.https.onRequest((request, response) => {
    const uid = request.get('userID');
    if (uid === null) {
        response.status(501).send('Thieu id')
    }
    const address = "userData/" + uid;
    admin.firestore().doc(address).get()
    .then(permisData => {
        const audio = permisData.data()
        response.status(200).send(audio)
    })
    .catch(error => {
        console.log(error)
        response.status(500).send(error)
    })
})

export const createNewAuth = 
functions.https.onRequest((request, response) => {
    const userID = request.get('userID');
    const userName = request.get('userName');
    const userPhone = request.get('userPhone');
    if (userID === null || userName === null || userPhone === null) {
        response.status(501).send('Thieu param')
    }
    admin.firestore().collection("userData").doc(userID).set({
        audioPermission: [],
        name: userName,
        phone: userPhone
    })
    .then(sta => {
        response.status(200).send(sta)
    })
    .catch(error => {
        console.log(error)
        response.status(500).send(error)
    })
})

export const getAudioList = 
functions.https.onRequest((request, response) => {
    admin.firestore().collection("audioInfo").get()
    .then(querySnapshot => {
        const result : FirebaseFirestore.DocumentData[] = [];
        querySnapshot.forEach(item => {
            result.push(item.data())
        })
        response.status(200).send(result)
      })
    .catch(error => {
        console.log(error)
        response.status(500).send(error)
    })
})

// export const getListQues = 
// functions.https.onRequest((request, response) => {
//     admin.firestore().collection("quiz/data").get()
//     .then(querySnapshot => {
//         const result : FirebaseFirestore.DocumentData[] = [];
//         querySnapshot.forEach(item => {
//             result.push(item.data)
//         })
//         response.status(200).send(result)
//       })
//     .catch(error => {
//         console.log(error)
//         response.status(500).send(error)
//     })
// })

export const getListQues = 
functions.https.onRequest((request, response) => {
    admin.firestore().collection("quiz").get()
    .then(querySnapshot => {
        // const result : FirebaseFirestore.DocumentData[] = [];
        // querySnapshot.forEach(item => {
        //     result.push(item.data())
        // })
        response.status(200).send(querySnapshot.docs[0].data())
      })
    .catch(error => {
        console.log(error)
        response.status(500).send(error)
    })
})

// export const getListQues = 
// functions.https.onRequest((request, response) => {
//     admin.firestore().collection("quiz").listDocuments()
//     .then(querySnapshot => {
//         const result : FirebaseFirestore.DocumentData[] = [];
//         querySnapshot.forEach(item => {
//             const subResult = [];
//             // subResult.push
// // tslint:disable-next-line: no-floating-promises
//             admin.firestore().collection("quiz/" + item.id).get().then(data => {
//                 // subResult.push(data)
//                 console.log(data);
//                 result.push(data)
//             })
//             // item.collection("data").get().then(subItem => {
//             //     subItem.forEach(subData => {
//             //         subResult.push(subData.data())
//             //     })
//             // })
//             // result.push(subResult)
//         })
//         response.status(200).send(result)
//       })
//     .catch(error => {
//         console.log(error)
//         response.status(500).send(error)
//     })
// })
