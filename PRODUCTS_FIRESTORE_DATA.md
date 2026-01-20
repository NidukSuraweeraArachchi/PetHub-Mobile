# Products Collection Data for Firestore

## Step 1: Create Products Collection in Firebase

Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/data

Click **"+ Start collection"** and name it: **products**

## Step 2: Add All Product Documents

### Add these documents one by one:

---

### TOYS Category (5 products)

**Document ID**: `toys_pedigree_10kg`
```
name: "Pedigree 10kg"
category: "Toys"
price: 2490
image: "assets/eating.jfif"
```

**Document ID**: `toys_pedigree_pro`
```
name: "PedigreePro 1.2kg"
category: "Toys"
price: 458
image: "assets/eating.jfif"
```

**Document ID**: `toys_henlo_dry`
```
name: "Henlo Dry"
category: "Toys"
price: 39.99
image: "assets/eating.jfif"
```

**Document ID**: `toys_royal_canin`
```
name: "Royal Canin"
category: "Toys"
price: 990
image: "assets/eating.jfif"
```

**Document ID**: `toys_canine_greek`
```
name: "Canine Greek"
category: "Toys"
price: 684
image: "assets/eating.jfif"
```

---

### CLOTHES Category (5 products)

**Document ID**: `clothes_woven_dress`
```
name: "Woven Dress"
category: "Clothes"
price: 684
image: "assets/clothes.jfif"
```

**Document ID**: `clothes_pet_shirt`
```
name: "Pet Shirt"
category: "Clothes"
price: 450
image: "assets/clothes.jfif"
```

**Document ID**: `clothes_sweater`
```
name: "Pet Sweater"
category: "Clothes"
price: 750
image: "assets/clothes.jfif"
```

**Document ID**: `clothes_raincoat`
```
name: "Pet Raincoat"
category: "Clothes"
price: 1200
image: "assets/clothes.jfif"
```

**Document ID**: `clothes_jacket`
```
name: "Pet Jacket"
category: "Clothes"
price: 900
image: "assets/clothes.jfif"
```

---

### FOOD Category (7 products)

**Document ID**: `food_pedigree_10kg`
```
name: "Pedigree 10kg"
category: "Food"
price: 2490
image: "assets/eating.jfif"
```

**Document ID**: `food_pedigree_pro`
```
name: "PedigreePro 1.2kg"
category: "Food"
price: 458
image: "assets/eating.jfif"
```

**Document ID**: `food_henlo_dry`
```
name: "Henlo Dry"
category: "Food"
price: 39.99
image: "assets/eating.jfif"
```

**Document ID**: `food_royal_canin`
```
name: "Royal Canin"
category: "Food"
price: 990
image: "assets/eating.jfif"
```

**Document ID**: `food_canine_greek`
```
name: "Canine Greek"
category: "Food"
price: 684
image: "assets/eating.jfif"
```

**Document ID**: `food_dog_bikkit`
```
name: "Dog Bikkit"
category: "Food"
price: 320
image: "assets/eating.jfif"
```

**Document ID**: `food_puppy_snacks`
```
name: "Puppy Snacks"
category: "Food"
price: 250
image: "assets/eating.jfif"
```

---

### MEDICINE Category (8 products)

**Document ID**: `medicine_alfalfa`
```
name: "Alfalfa tonic"
category: "Medicine"
price: 250
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_diarrhoea`
```
name: "Diarrhoea tablets"
category: "Medicine"
price: 90
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_thirst_drop`
```
name: "Drop for excessive thirst"
category: "Medicine"
price: 100
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_ear_drop`
```
name: "Ear drop"
category: "Medicine"
price: 130
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_wound_lotion`
```
name: "Wound lotion"
category: "Medicine"
price: 684
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_joint_tablets`
```
name: "Joint Tablets"
category: "Medicine"
price: 180
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_liv_52`
```
name: "Liv 52 metabolism"
category: "Medicine"
price: 350
image: "assets/medicine.jfif"
```

**Document ID**: `medicine_multivitamin`
```
name: "Multivitamin for pets"
category: "Medicine"
price: 350
image: "assets/medicine.jfif"
```

---

### ACCESSORIES Category (7 products)

**Document ID**: `accessories_muzzle`
```
name: "Mouth Cover muzzles"
category: "Accessories"
price: 2490
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_brush`
```
name: "Hair Brush"
category: "Accessories"
price: 450
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_bed`
```
name: "Portable Bed"
category: "Accessories"
price: 1800
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_harness`
```
name: "Dog Harness"
category: "Accessories"
price: 990
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_leash`
```
name: "Dog leash"
category: "Accessories"
price: 340
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_retractable_leash`
```
name: "Retractable Dog Leash"
category: "Accessories"
price: 720
image: "assets/accessories.jfif"
```

**Document ID**: `accessories_bowl`
```
name: "Food Bowl 700ml"
category: "Accessories"
price: 270
image: "assets/accessories.jfif"
```

---

## Step 3: Update Firestore Rules

Go to: https://console.firebase.google.com/project/pethub-app-a0f7a/firestore/rules

Make sure rules include products collection:

```
// ==================== PRODUCTS COLLECTION ====================
match /products/{productId} {
  // Allow ALL users to READ products
  allow read: if true;
  
  // Only allow admin writes
  allow write: if request.auth.token.admin == true;
}
```

---

## Step 4: How Data is Being Used

✅ **Current**: Products hardcoded in app (working fine)
✅ **Purchase History**: Stored in Firestore at `users/{userId}/purchases/` with each item
✅ **User Profile**: Shows purchases from Firestore with correct currency (Rs)

The products in Firestore are for future enhancements like:
- Admin dashboard to manage products
- Real-time price updates
- Product recommendations
- Analytics on popular products
