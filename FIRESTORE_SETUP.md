# Firestore Database Setup with Security & Indexes

## ✅ Step 1: Firestore Security Rules

### Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/rules

Replace all rules with:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection - each user can only access their own document
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow create: if request.auth.uid == userId && 
                       request.resource.data.uid == userId &&
                       request.resource.data.name is string &&
                       request.resource.data.phone is string;
      allow update: if request.auth.uid == userId;
      allow delete: if request.auth.uid == userId;
    }
    
    // Orders collection - users can create and read their own orders
    match /orders/{orderId} {
      allow read: if request.auth.uid == resource.data.userId;
      allow create: if request.auth.uid == request.resource.data.userId;
      allow update: if request.auth.uid == resource.data.userId;
      allow delete: if request.auth.uid == resource.data.userId;
    }
    
    // Default deny all other access
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

Click **"Publish"**

---

## ✅ Step 2: Create Firestore Indexes

### Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/indexes

#### Index 1: Users by Phone (For searching users)
- **Collection**: `users`
- **Fields to index**:
  1. `phone` (Ascending)
  2. `createdAt` (Descending)

#### Index 2: Orders by User & Date (For order history)
- **Collection**: `orders`
- **Fields to index**:
  1. `userId` (Ascending)
  2. `createdAt` (Descending)

#### Index 3: Orders by Status & Date (For admin dashboard)
- **Collection**: `orders`
- **Fields to index**:
  1. `status` (Ascending)
  2. `createdAt` (Descending)

---

## ✅ Step 3: Firestore Collection Structure

Your database will automatically create this structure:

```
firestore-root
│
├── users/ (collection)
│   ├── {uid1}/ (document)
│   │   ├── name: "Niduk"
│   │   ├── phone: "+94 0712345678"
│   │   ├── uid: "{uid1}"
│   │   ├── email: "user@example.com"
│   │   ├── createdAt: Timestamp(2026-01-19...)
│   │   └── updatedAt: Timestamp(2026-01-19...)
│   │
│   └── {uid2}/ (document)
│       ├── name: "Jane"
│       ├── phone: "+94 0701234567"
│       └── ...
│
└── orders/ (collection)
    ├── {orderId1}/ (document)
    │   ├── userId: "{uid1}"
    │   ├── packageName: "Day Care- 5D"
    │   ├── packagePrice: "Rs 600"
    │   ├── status: "completed"
    │   ├── createdAt: Timestamp(...)
    │   └── ...
    │
    └── {orderId2}/ (document)
        └── ...
```

---

## ✅ Step 4: Code Already Updated ✓

The app code has been updated to use Firestore with:
- ✅ `cloud_firestore` package added to pubspec.yaml
- ✅ Server timestamps (auto-managed by Firebase)
- ✅ Proper field structure
- ✅ Error handling with timeouts

---

## ✅ Testing

1. Run the app:
```bash
cd e:\pet-app-main\basics
flutter pub get
flutter run -d chrome
```

2. Go through registration:
   - Enter Name: `Niduk`
   - Enter Phone: `0712345678` (without +94)
   - Send code
   - Use test OTP: `123456`

3. Check Firestore Console → Collections → users
   - Your data should appear! ✓

---

## 🔒 Security Features

✅ **Authentication Required** - Only logged-in users can access
✅ **User Isolation** - Users can only see their own data
✅ **Write Validation** - Data must match required fields
✅ **Timestamps** - Server-side automatic timestamps
✅ **Scalable Indexes** - Fast queries for future features

---

## 📊 Firestore vs Realtime Database

| Feature | Firestore | Realtime DB |
|---------|-----------|-------------|
| Query Capability | Advanced queries ✓ | Limited |
| Indexing | Automatic + Custom | Manual |
| Security | Fine-grained ✓ | Basic |
| Scalability | Better ✓ | Good |
| Real-time | Yes | Yes |
| Cost | Pay-per-read ✓ | Pay-per-GB |

**Firestore is recommended** for this app! ✓

---

## 🎯 Next Steps (Optional)

To expand the app with orders:

```dart
// Save order to Firestore
await FirebaseFirestore.instance.collection('orders').add({
  'userId': currentUserId,
  'packageName': 'Day Care- 5D',
  'packagePrice': '600',
  'status': 'pending',
  'createdAt': FieldValue.serverTimestamp(),
});

// Query user's orders
final orders = await FirebaseFirestore.instance
  .collection('orders')
  .where('userId', isEqualTo: currentUserId)
  .orderBy('createdAt', descending: true)
  .get();
```

Everything is now **production-ready** with proper security! 🚀
