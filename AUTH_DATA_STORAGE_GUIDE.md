# Complete Guide: User Authentication & Data Storage

## ✅ What's Fixed:

1. ✅ **Persistent Login** - User stays logged in after verification
2. ✅ **User Profile Shows Firestore Data** - Real-time data from database
3. ✅ **Shows Data Location** - Tells user where their data is stored
4. ✅ **Proper Logout** - Can log out anytime from user profile

---

## 📍 Where User Data is Stored:

### Location in Firestore:
```
Firebase Console
  ↓
Firestore Database (pethub-app-a0f7a)
  ↓
Collections
  ↓
users (collection)
  ↓
{UserID} (document)
  ├── name: "Your Name"
  ├── phone: "+94 0712345678"
  ├── uid: "{UserID}"
  ├── email: ""
  ├── createdAt: Timestamp
  ├── updatedAt: Timestamp
  └── authMethod: "phone"
```

### Access Firestore Console:
https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data/~2Fusers

---

## 🧪 Complete Testing Flow:

### Step 1: Add Test Phone Numbers to Firebase

1. Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/authentication/phone

2. Scroll to **"Phone numbers for testing"**

3. Add these test numbers:
   ```
   +94712345678  →  Test OTP: 123456
   +94701234567  →  Test OTP: 111111
   ```

4. Click **"Add"** for each

---

### Step 2: Update Firestore Security Rules

1. Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/rules

2. Replace all rules with:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow create: if request.auth.uid == userId && 
                       request.auth.uid != null &&
                       request.resource.data.uid == userId &&
                       request.resource.data.name is string &&
                       request.resource.data.phone is string;
      allow update: if request.auth.uid == userId;
      allow delete: if request.auth.uid == userId;
    }
    
    match /orders/{orderId} {
      allow read: if request.auth.uid == resource.data.userId;
      allow create: if request.auth.uid == request.resource.data.userId;
      allow update: if request.auth.uid == resource.data.userId;
      allow delete: if request.auth.uid == resource.data.userId;
    }
    
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

3. Click **"Publish"**

---

### Step 3: Run the App

```bash
cd e:\pet-app-main\basics
flutter pub get
flutter run -d chrome
```

---

### Step 4: Test Registration & Login Flow

#### First Time (Registration):
1. **Phone Verification Screen appears**
2. Enter:
   - Name: `Niduk` (or your name)
   - Phone: `0712345678` (without +94)
3. Click **"Send the code"**
4. Enter OTP: `123456`
5. ✅ **You're logged in!** → See home screen

#### User Profile Screen:
1. Click **"USER"** in bottom navigation
2. **See your information from Firestore:**
   - Name
   - Phone
   - Email
   - User ID
   - Data Location info
3. Click **"Log Out"** to logout

#### After Logout:
1. ✅ **Phone Verification screen appears** (because you're not logged in)
2. Enter phone number again
3. Enter OTP
4. ✅ **Logged back in!** → Firestore loads your saved data

---

## 🔒 Security Flow:

```
User Registration
  ↓
Phone verified by Firebase Auth
  ↓
User data saved to Firestore
  ↓
Auth state persisted
  ↓
[Reload browser or close app]
  ↓
Auth wrapper checks: Is user logged in?
  ↓
YES → Show app (Home screen)
NO → Show phone verification
```

---

## 📊 Viewing Your Data in Firestore:

1. Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data

2. Click on **"users"** collection

3. See all registered users

4. Click on a user document to see their data:
   ```
   Document ID: NnnOgoqWbLbDnyM8cGgt
   Fields:
   - name: "Niduk"
   - phone: "+94 0712345678"
   - uid: "NnnOgoqWbLbDnyM8cGgt"
   - email: ""
   - createdAt: Jan 19, 2026 at 5:30 PM
   - authMethod: "phone"
   ```

---

## 🎯 What Each Screen Shows:

### Login Screen (Phone Verification)
- Input name and phone
- Validates inputs
- Sends OTP

### OTP Screen
- Enter 6-digit code
- Shows: "✓ Registration successful! Welcome!"
- Auto-saves to Firestore
- Auto-redirects to app

### User Profile Screen
- **Shows live data from Firestore**
- Displays name, phone, email, user ID
- Shows where data is stored
- "Log Out" button properly signs out

### Home Screen
- Only visible if user is logged in
- If logged out, redirects to phone verification

---

## ✅ How to Know It's Working:

1. ✅ User Profile shows your actual data
2. ✅ Firestore Console shows your document in `/users/{uid}`
3. ✅ After logout, you need to log back in
4. ✅ After browser refresh, you stay logged in
5. ✅ Data persists across sessions

---

## 🐛 Troubleshooting:

### Problem: Data not showing in profile
- **Solution**: Check Firestore Rules are published
- **Solution**: Check browser console (F12) for errors

### Problem: Can't log back in
- **Solution**: Verify test phone numbers are added in Firebase Console
- **Solution**: Use exact OTP code from console

### Problem: Still on phone verification after login
- **Solution**: Make sure `AuthenticationWrapper` is working (check browser console)
- **Solution**: Clear browser cache and refresh

---

## 📱 Test Accounts (Pre-added):

These are test numbers you added:
```
Phone: +94712345678
OTP: 123456

Phone: +94701234567
OTP: 111111
```

Use these to test without needing real SMS!

---

## Next Steps (Optional):

- Add order history to user profile
- Add edit profile functionality
- Add multiple phone numbers
- Add profile picture upload
- Add order tracking
