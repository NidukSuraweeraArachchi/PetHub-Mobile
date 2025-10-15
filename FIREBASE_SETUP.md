# Firebase Realtime Database Setup

## Issue: Data Not Saving to Database

The app is ready to save user data, but **Firebase Realtime Database Rules** are blocking writes.

---

## ✅ Solution: Update Database Rules

### Step 1: Open Firebase Console
Navigate to: https://console.firebase.google.com/project/pethub-app-a0f7a/database/pethub-app-a0f7a-default-rtdb/rules

### Step 2: Replace Rules with This:

```json
{
  "rules": {
    "users": {
      "$uid": {
        ".read": "auth.uid === $uid || root.child('admin').child(auth.uid).exists()",
        ".write": "auth.uid === $uid"
      }
    },
    ".read": false,
    ".write": false
  }
}
```

### Step 3: Click "Publish"

---

## What These Rules Do:

✅ **Each user can write** their own data under `/users/{uid}`
✅ **Each user can read** only their own profile
✅ **Prevents unauthorized access** to other users' data
✅ **Default deny** for all other paths

---

## Database Structure:

After setup, your database will look like:

```
root
├── users
│   ├── {uid1}
│   │   ├── name: "John"
│   │   ├── phone: "+91 9876543210"
│   │   ├── uid: "{uid1}"
│   │   └── createdAt: "2026-01-19T10:30:00.000Z"
│   └── {uid2}
│       ├── name: "Jane"
│       ├── phone: "+91 9876543211"
│       ├── uid: "{uid2}"
│       └── createdAt: "2026-01-19T10:35:00.000Z"
```

---

## Testing:

1. Run the app: `flutter run -d chrome`
2. Go to Phone Verification screen
3. Enter valid name and phone
4. Complete OTP verification
5. Check Firebase Console - user data should appear under **Data** tab

---

## Error Handling:

The app now includes:
- ✅ Timeout handling (10 seconds)
- ✅ Better error logging
- ✅ User authentication still works even if DB write fails
- ✅ Console logs for debugging

Check browser console (F12 → Console tab) for detailed errors if needed.
