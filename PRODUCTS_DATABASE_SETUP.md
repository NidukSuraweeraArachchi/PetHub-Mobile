# Firebase Products Database Setup (Optional Enhancement)

## Current Setup (Working)
- Products are stored in the Flutter app code
- User purchases are stored in Firestore at: `users/{userId}/purchases/`
- **This is already working!**

## Optional: Store Products in Firestore

If you want to manage products from Firebase Console (recommended for future):

### Step 1: Create Products Collection in Firebase Console

1. Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data
2. Click **"+ Start collection"**
3. Name it: `products`
4. Click **"Next"**

### Step 2: Add Sample Product Documents

Create documents with these fields:

**Document ID**: `toys_001`
```json
{
  "name": "Pedigree 10kg",
  "category": "Toys",
  "price": 2490,
  "image": "assets/eating.jfif",
  "description": "High quality pet toy"
}
```

**Document ID**: `clothes_001`
```json
{
  "name": "Woven Dress",
  "category": "Clothes",
  "price": 684,
  "image": "assets/clothes.jfif",
  "description": "Comfortable pet clothing"
}
```

### Step 3: Add Firestore Rules for Products

In your Firestore Rules (https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/rules), add:

```
// ==================== PRODUCTS COLLECTION ====================
match /products/{productId} {
  // Allow ALL users to READ products
  allow read: if true;
  
  // Only admin can write (restrict as needed)
  allow write: if request.auth.token.admin == true;
}
```

### Step 4: Update App Code (Not Required Now)

If you want the app to fetch from Firestore instead of hardcoded:

```dart
StreamBuilder(
  stream: FirebaseFirestore.instance.collection('products')
      .where('category', isEqualTo: 'Toys')
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final products = snapshot.data!.docs;
      // Build UI from products
    }
  }
)
```

## What's Working Right Now

✅ Products display in app (hardcoded)
✅ Users can add items to profile
✅ Items saved to Firestore
✅ User profile shows purchases from Firestore

## Priority Now

**FIRST**: Update Firestore Security Rules (see FIRESTORE_RULES_UPDATE.md)
**THEN**: Test "Add to Items" functionality
**OPTIONAL**: Set up Products collection later for better management
