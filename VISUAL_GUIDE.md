# 📱 Visual Guide: How the App Works

## 🎯 User Flow

```
┌─────────────────────────────────────────────────────────────┐
│                   USER OPENS APP                            │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                   LOGIN SCREEN                              │
│  Email: test-user@pethubapp.com                            │
│  Password: (from your records)                             │
│                                                             │
│  ➜ Or use Phone Verification                              │
└───────────────────────┬─────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│              HOME SCREEN (with tabs)                        │
│                                                             │
│  📱 Home    🛍️ Shop    ❤️ Favorites    👤 Profile          │
└───────────────────────┬─────────────────────────────────────┘
                        │
          ┌─────────────┴─────────────┐
          │                           │
          ▼                           ▼
┌──────────────────────┐    ┌──────────────────────┐
│   HOME TAB           │    │   SHOP TAB           │
│                      │    │                      │
│ - News/Tips         │    │ Toys                 │
│ - Health Info       │    │ Clothes              │
│                      │    │ Food                 │
│                      │    │ Medicine             │
│                      │    │ Accessories          │
└──────────────────────┘    └──────────┬───────────┘
                                        │
                                        ▼
                            ┌──────────────────────┐
                            │   PRODUCT SCREEN     │
                            │                      │
                            │  - Product Image     │
                            │  - Product Name      │
                            │  - Price (Rs)        │
                            │  - Quantity Selector │
                            │                      │
                            │  [Add to My Items]   │
                            │  [Buy Now]           │
                            └──────────┬───────────┘
                                        │
                 ┌──────────────────────┴──────────────────────┐
                 │                                             │
                 ▼                                             ▼
        ┌──────────────────────┐                    ┌──────────────────────┐
        │  ITEM ADDED TO       │                    │  PAYMENT SCREEN      │
        │  FIRESTORE           │                    │                      │
        │                      │                    │  Order Summary       │
        │  ✓ Success Message   │                    │  - Product Name      │
        │                      │                    │  - Price (Rs)        │
        │  "Item added to      │                    │  - Details           │
        │   your profile!"     │                    │                      │
        └──────────┬───────────┘                    │  [Pay with UPI]      │
                   │                                └──────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  USER PROFILE TAB     │
        │                       │
        │  👤 Profile Info      │
        │    - Name             │
        │    - Email            │
        │    - Phone            │
        │    - User ID          │
        │    - Data Location    │
        │                       │
        │  📦 Your Purchases    │
        │      & Items          │
        │                       │
        │  ┌────────────────┐   │
        │  │ Item #1        │   │
        │  │ Category: Toys │   │
        │  │ Price: Rs 2490 │   │  ← Shows ALL items added
        │  │ Qty: 1         │   │     with correct currency
        │  │ Date: Jan 20   │   │
        │  └────────────────┘   │
        │                       │
        │  ┌────────────────┐   │
        │  │ Item #2        │   │
        │  │ Category:      │   │
        │  │ Clothes        │   │
        │  │ Price: Rs 684  │   │
        │  │ Qty: 1         │   │
        │  │ Date: Jan 20   │   │
        │  └────────────────┘   │
        │                       │
        │  [Logout]             │
        └──────────────────────┘
```

---

## 🗄️ Database Structure

```
FIREBASE FIRESTORE
│
├── 📁 users (collection)
│   │
│   └── 📄 test-user-123 (document)
│       │
│       ├── name: "Test user"
│       ├── email: "test-user@pethubapp.com"
│       ├── phone: "+94712345678"
│       ├── uid: "test-user-123"
│       │
│       └── 📁 purchases (subcollection)
│           │
│           ├── 📄 doc_1 (item added)
│           │   ├── itemName: "Retractable Dog Leash"
│           │   ├── category: "Accessories"
│           │   ├── price: "720"
│           │   ├── quantity: 1
│           │   └── createdAt: <timestamp>
│           │
│           └── 📄 doc_2 (item added)
│               ├── itemName: "Woven Dress"
│               ├── category: "Clothes"
│               ├── price: "684"
│               ├── quantity: 2
│               └── createdAt: <timestamp>
│
└── 📁 products (collection) - OPTIONAL
    │
    ├── 📄 toys_001
    │   ├── name: "Pedigree 10kg"
    │   ├── category: "Toys"
    │   ├── price: 2490
    │   └── image: "assets/eating.jfif"
    │
    ├── 📄 clothes_001
    │   ├── name: "Woven Dress"
    │   ├── category: "Clothes"
    │   ├── price: 684
    │   └── image: "assets/clothes.jfif"
    │
    └── ... (32 products total)
```

---

## 🔄 Data Flow: "Add to Items"

```
┌──────────────────────────────────┐
│   USER CLICKS PRODUCT             │
│   (e.g., "Woven Dress" - Rs 684)  │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   DETAIL SCREEN OPENS             │
│   - Show product image            │
│   - Show product name             │
│   - Show price (Rs)               │
│   - Quantity selector (1, 2, 3...)│
│   - Two buttons:                  │
│     • Add to My Items (green)     │
│     • Buy Now (blue)              │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   USER SELECTS QUANTITY           │
│   (e.g., quantity = 2)            │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   USER CLICKS "Add to My Items"   │
│   ↓                               │
│   FUNCTION: addItemToProfile()    │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   AUTHENTICATE USER               │
│   ✓ Get current user from         │
│     FirebaseAuth                  │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   CREATE FIRESTORE DOCUMENT       │
│   Location:                       │
│   users/{userId}/purchases/{id}   │
│                                   │
│   Fields:                         │
│   ├── itemName: "Woven Dress"    │
│   ├── category: "Clothes"        │
│   ├── price: "684"               │
│   ├── quantity: 2                │
│   └── createdAt: <serverTime>    │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   FIRESTORE RULES CHECK           │
│   ✓ User is authenticated         │
│   ✓ Writing to own purchases/     │
│   ✓ All required fields present   │
│   → PERMISSION GRANTED            │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   DOCUMENT SAVED TO FIRESTORE     │
│   ✓ Data persisted               │
│   ✓ Real-time sync enabled       │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   SHOW SUCCESS MESSAGE            │
│   ✓ Item added to your profile!   │
│   (green snackbar)                │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   NAVIGATE BACK                   │
│   ↓                               │
│   Return to product category      │
└─────────────┬──────────────────────┘
              │
              ▼
┌──────────────────────────────────┐
│   USER GOES TO PROFILE            │
│   ↓                               │
│   PROFILE READS FROM FIRESTORE    │
│   StreamBuilder listens to:       │
│   users/{userId}/purchases/       │
│   ↓                               │
│   REAL-TIME SYNC:                 │
│   Displays all items with:        │
│   • Item name                     │
│   • Category                      │
│   • Price (Rs format)             │
│   • Quantity                      │
│   • Date added                    │
└──────────────────────────────────┘
```

---

## 🔐 Security Rules Flow

```
USER TRIES TO ADD ITEM
        │
        ▼
IS USER LOGGED IN?
├─ No → ❌ Show error: "Please login first"
│
└─ Yes → ✓
        ▼
   FIRESTORE RULES CHECK
   ├─ request.auth.uid == userId?
   │  └─ No → ❌ PERMISSION DENIED
   │
   └─ Yes → ✓
           ▼
        ARE ALL REQUIRED FIELDS PRESENT?
        ├─ itemName (string) → No → ❌ INVALID
        ├─ category (string) → No → ❌ INVALID
        ├─ price (string)    → No → ❌ INVALID
        ├─ quantity (number) → No → ❌ INVALID
        │
        └─ All present → ✓
                ▼
            ✅ ALLOW WRITE
            Document saved to Firestore
```

---

## 💰 Currency Display

### Before Fix ❌
```
Price: $720
Price: $684
Price: $450
```

### After Fix ✅
```
Price: Rs 720
Price: Rs 684
Price: Rs 450
```

**Files Changed**:
- user.dart (purchase history)
- upi_payment_screen.dart (payment screen)

---

## 📊 Features Matrix

| Feature | Status | Where |
|---------|--------|-------|
| Browse Products | ✅ | Home → Shop → Select Category |
| Product Details | ✅ | Click Product → DetailScreen |
| Quantity Selector | ✅ | Detail Screen (increment/decrement) |
| Add to Items | ✅ | DetailScreen → "Add to My Items" button |
| Success Feedback | ✅ | Green snackbar after adding |
| Firestore Storage | ✅ | users/{uid}/purchases/ |
| Purchase History | ✅ | Profile → "Your Purchases & Items" |
| Real-time Sync | ✅ | StreamBuilder updates automatically |
| Currency Display | ✅ | Rs everywhere (not $) |
| Logout | ✅ | Profile → Logout button |
| Authentication | ✅ | Email/Password + Phone OTP |

---

## 🎯 Quick Reference

### Important Numbers
- **Total Products**: 32
- **Categories**: 5 (Toys, Clothes, Food, Medicine, Accessories)
- **Max Price**: Rs 2490 (Muzzles, Pedigree 10kg)
- **Min Price**: Rs 39 (Henlo Dry)
- **Test User**: test-user@pethubapp.com

### Important Paths
- **App Root**: E:\pet-app-main\basics
- **User Profile**: lib/2_bottom_nav_screens/user.dart
- **Product Screens**: lib/2_bottom_nav_screens/{category}/
- **Firestore Database**: users/ → purchases/ collection
- **Firebase Console**: https://console.firebase.google.com/project/pethub-app-a0f7a

---

## ✅ What to Test

1. ✓ Open app → Login → Browse products
2. ✓ Click "Add to My Items" → Success message
3. ✓ Check User Profile → Item shows with Rs currency
4. ✓ Add multiple items → All appear in profile
5. ✓ Logout & Login → Purchases persist
6. ✓ No error messages in console

---

**Everything is working! You're ready to go! 🚀**
