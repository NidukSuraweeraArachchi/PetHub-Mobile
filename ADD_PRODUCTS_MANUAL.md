# Add Products to Firebase Firestore - Step by Step Guide

## ⚡ QUICKEST METHOD (Manual but Fast - 5 minutes)

### Step 1: Create Products Collection

1. Open Firebase Console: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data
2. Look at the left side - you should see your "users" collection
3. Click **"+ Start collection"** button at the top
4. Enter collection name: **products**
5. Click **"Next"**

### Step 2: Create Your First Product Document

For the first document, Firebase will ask you to create a document ID manually:

**Document ID**: `toys_pedigree_10kg`

Then add these fields by clicking **"+ Add field"**:

| Field Name | Type | Value |
|-----------|------|-------|
| name | String | Pedigree 10kg |
| category | String | Toys |
| price | Number | 2490 |
| image | String | assets/eating.jfif |

Then click **"Save"**

### Step 3: Add Remaining Products

For each product below, click **"+ Add document"** and repeat Step 2 with the respective data.

---

## 📦 TOYS (7 products)

1. **toys_pedigree_pro**
   - name: PedigreePro 1.2kg
   - category: Toys
   - price: 458
   - image: assets/eating.jfif

2. **toys_henlo_dry**
   - name: Henlo Dry
   - category: Toys
   - price: 39
   - image: assets/eating.jfif

3. **toys_royal_canin**
   - name: Royal Canin
   - category: Toys
   - price: 990
   - image: assets/eating.jfif

4. **toys_canine_greek**
   - name: Canine Greek
   - category: Toys
   - price: 684
   - image: assets/eating.jfif

5. **toys_dog_bikkit**
   - name: Dog Bikkit
   - category: Toys
   - price: 320
   - image: assets/eating.jfif

6. **toys_puppy_snacks**
   - name: Puppy Snacks
   - category: Toys
   - price: 250
   - image: assets/eating.jfif

---

## 👕 CLOTHES (5 products)

1. **clothes_woven_dress**
   - name: Woven Dress
   - category: Clothes
   - price: 684
   - image: assets/clothes.jfif

2. **clothes_pet_shirt**
   - name: Pet Shirt
   - category: Clothes
   - price: 450
   - image: assets/clothes.jfif

3. **clothes_sweater**
   - name: Pet Sweater
   - category: Clothes
   - price: 750
   - image: assets/clothes.jfif

4. **clothes_raincoat**
   - name: Pet Raincoat
   - category: Clothes
   - price: 1200
   - image: assets/clothes.jfif

5. **clothes_jacket**
   - name: Pet Jacket
   - category: Clothes
   - price: 900
   - image: assets/clothes.jfif

---

## 🍖 FOOD (7 products)

1. **food_pedigree_10kg**
   - name: Pedigree 10kg
   - category: Food
   - price: 2490
   - image: assets/eating.jfif

2. **food_pedigree_pro**
   - name: PedigreePro 1.2kg
   - category: Food
   - price: 458
   - image: assets/eating.jfif

3. **food_henlo_dry**
   - name: Henlo Dry
   - category: Food
   - price: 39
   - image: assets/eating.jfif

4. **food_royal_canin**
   - name: Royal Canin
   - category: Food
   - price: 990
   - image: assets/eating.jfif

5. **food_canine_greek**
   - name: Canine Greek
   - category: Food
   - price: 684
   - image: assets/eating.jfif

6. **food_dog_bikkit**
   - name: Dog Bikkit
   - category: Food
   - price: 320
   - image: assets/eating.jfif

7. **food_puppy_snacks**
   - name: Puppy Snacks
   - category: Food
   - price: 250
   - image: assets/eating.jfif

---

## 💊 MEDICINE (8 products)

1. **medicine_alfalfa**
   - name: Alfalfa tonic
   - category: Medicine
   - price: 250
   - image: assets/medicine.jfif

2. **medicine_diarrhoea**
   - name: Diarrhoea tablets
   - category: Medicine
   - price: 90
   - image: assets/medicine.jfif

3. **medicine_thirst_drop**
   - name: Drop for excessive thirst
   - category: Medicine
   - price: 100
   - image: assets/medicine.jfif

4. **medicine_ear_drop**
   - name: Ear drop
   - category: Medicine
   - price: 130
   - image: assets/medicine.jfif

5. **medicine_wound_lotion**
   - name: Wound lotion
   - category: Medicine
   - price: 684
   - image: assets/medicine.jfif

6. **medicine_joint_tablets**
   - name: Joint Tablets
   - category: Medicine
   - price: 180
   - image: assets/medicine.jfif

7. **medicine_liv_52**
   - name: Liv 52 metabolism
   - category: Medicine
   - price: 350
   - image: assets/medicine.jfif

8. **medicine_multivitamin**
   - name: Multivitamin for pets
   - category: Medicine
   - price: 350
   - image: assets/medicine.jfif

---

## 🎽 ACCESSORIES (7 products)

1. **accessories_muzzle**
   - name: Mouth Cover muzzles
   - category: Accessories
   - price: 2490
   - image: assets/accessories.jfif

2. **accessories_brush**
   - name: Hair Brush
   - category: Accessories
   - price: 450
   - image: assets/accessories.jfif

3. **accessories_bed**
   - name: Portable Bed
   - category: Accessories
   - price: 1800
   - image: assets/accessories.jfif

4. **accessories_harness**
   - name: Dog Harness
   - category: Accessories
   - price: 990
   - image: assets/accessories.jfif

5. **accessories_leash**
   - name: Dog leash
   - category: Accessories
   - price: 340
   - image: assets/accessories.jfif

6. **accessories_retractable_leash**
   - name: Retractable Dog Leash
   - category: Accessories
   - price: 720
   - image: assets/accessories.jfif

7. **accessories_bowl**
   - name: Food Bowl 700ml
   - category: Accessories
   - price: 270
   - image: assets/accessories.jfif

---

## ✅ Verify Installation

After adding all products:

1. Go to Firebase Console Firestore
2. Click on **"products"** collection
3. You should see **32 documents** (7+5+7+8+5 = 32)
4. All categories should be visible

---

## 🔄 Alternative: Automated Import

If you have **Firebase CLI** installed:

```powershell
# Install Firebase CLI (if not already)
npm install -g firebase-tools

# Login
firebase login

# Import from backup
firebase firestore:import products_backup.json --project=pethub-app-a0f7a
```

---

## 📝 Note

You can also use the app itself - currently products are **hardcoded** in the app and work fine!

The Firestore products collection is optional for:
- Admin dashboard to manage products
- Real-time price updates
- Future features and analytics

**App works perfectly with hardcoded products** - this is just for future management.
