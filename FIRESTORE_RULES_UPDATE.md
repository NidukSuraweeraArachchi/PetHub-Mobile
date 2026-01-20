# Fix Firestore Security Rules - URGENT

## Error You're Seeing:
`[cloud_firestore/permission-denied] Missing or insufficient permissions`

This happens because Firestore rules don't allow writing to the `purchases` subcollection.

## How to Fix:

### Step 1: Go to Firebase Console
1. Open: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/rules
2. You should see the "Firestore Rules" editor

### Step 2: Copy the NEW Rules
Copy all content from: `E:\pet-app-main\FIRESTORE_RULES.txt`

### Step 3: Replace in Firebase Console
1. **DELETE ALL** existing rules in the editor
2. **PASTE** the entire content from the file
3. Click **"Publish"** button (blue button in top right)

### Step 4: Wait for Deployment
- It should take 10-30 seconds
- You'll see a notification when rules are live

### Step 5: Test in App
- Go back to the app (should still be running on Chrome)
- Click "Add to My Items" on any product
- If successful, you'll see: ✓ Item added to your profile!

## What Changed:

Added new `purchases` subcollection rules that allow authenticated users to:
- ✅ Create new purchase items
- ✅ Read their own purchases
- ✅ Update purchase items
- ✅ Delete purchases

The key addition:
```
match /purchases/{purchaseId} {
  allow read: if request.auth.uid == userId;
  allow create: if request.auth.uid == userId && request.auth.uid != null;
  allow update: if request.auth.uid == userId && request.auth.uid != null;
  allow delete: if request.auth.uid == userId;
}
```

## After Rules are Updated:
- Users can add items to their profile
- Items appear in user profile purchase history
- All data stored in Firestore: `users/{userId}/purchases/{itemId}`
