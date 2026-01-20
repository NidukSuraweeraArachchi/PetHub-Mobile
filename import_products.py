#!/usr/bin/env python3
"""
Firebase Firestore Products Importer
This script adds all PetHub products to Firestore
"""

import json
from firebase_admin import credentials, firestore, initialize_app

# Initialize Firebase (requires credentials)
try:
    # Try to use application default credentials
    db = firestore.client()
    print("✓ Connected to Firebase")
except Exception as e:
    print("Error: Could not connect to Firebase")
    print("To use this script, you need to:")
    print("1. Install: pip install firebase-admin")
    print("2. Set GOOGLE_APPLICATION_CREDENTIALS environment variable")
    print("3. Download service account key from Firebase Console")
    exit(1)

# All products data
PRODUCTS = {
    "Toys": [
        {"name": "Pedigree 10kg", "price": 2490, "image": "assets/eating.jfif"},
        {"name": "PedigreePro 1.2kg", "price": 458, "image": "assets/eating.jfif"},
        {"name": "Henlo Dry", "price": 39, "image": "assets/eating.jfif"},
        {"name": "Royal Canin", "price": 990, "image": "assets/eating.jfif"},
        {"name": "Canine Greek", "price": 684, "image": "assets/eating.jfif"},
        {"name": "Dog Bikkit", "price": 320, "image": "assets/eating.jfif"},
        {"name": "Puppy Snacks", "price": 250, "image": "assets/eating.jfif"},
    ],
    "Clothes": [
        {"name": "Woven Dress", "price": 684, "image": "assets/clothes.jfif"},
        {"name": "Pet Shirt", "price": 450, "image": "assets/clothes.jfif"},
        {"name": "Pet Sweater", "price": 750, "image": "assets/clothes.jfif"},
        {"name": "Pet Raincoat", "price": 1200, "image": "assets/clothes.jfif"},
        {"name": "Pet Jacket", "price": 900, "image": "assets/clothes.jfif"},
    ],
    "Food": [
        {"name": "Pedigree 10kg", "price": 2490, "image": "assets/eating.jfif"},
        {"name": "PedigreePro 1.2kg", "price": 458, "image": "assets/eating.jfif"},
        {"name": "Henlo Dry", "price": 39, "image": "assets/eating.jfif"},
        {"name": "Royal Canin", "price": 990, "image": "assets/eating.jfif"},
        {"name": "Canine Greek", "price": 684, "image": "assets/eating.jfif"},
        {"name": "Dog Bikkit", "price": 320, "image": "assets/eating.jfif"},
        {"name": "Puppy Snacks", "price": 250, "image": "assets/eating.jfif"},
    ],
    "Medicine": [
        {"name": "Alfalfa tonic", "price": 250, "image": "assets/medicine.jfif"},
        {"name": "Diarrhoea tablets", "price": 90, "image": "assets/medicine.jfif"},
        {"name": "Drop for excessive thirst", "price": 100, "image": "assets/medicine.jfif"},
        {"name": "Ear drop", "price": 130, "image": "assets/medicine.jfif"},
        {"name": "Wound lotion", "price": 684, "image": "assets/medicine.jfif"},
        {"name": "Joint Tablets", "price": 180, "image": "assets/medicine.jfif"},
        {"name": "Liv 52 metabolism", "price": 350, "image": "assets/medicine.jfif"},
        {"name": "Multivitamin for pets", "price": 350, "image": "assets/medicine.jfif"},
    ],
    "Accessories": [
        {"name": "Mouth Cover muzzles", "price": 2490, "image": "assets/accessories.jfif"},
        {"name": "Hair Brush", "price": 450, "image": "assets/accessories.jfif"},
        {"name": "Portable Bed", "price": 1800, "image": "assets/accessories.jfif"},
        {"name": "Dog Harness", "price": 990, "image": "assets/accessories.jfif"},
        {"name": "Dog leash", "price": 340, "image": "assets/accessories.jfif"},
        {"name": "Retractable Dog Leash", "price": 720, "image": "assets/accessories.jfif"},
        {"name": "Food Bowl 700ml", "price": 270, "image": "assets/accessories.jfif"},
    ]
}

def add_products():
    """Add all products to Firestore"""
    total = 0
    
    for category, items in PRODUCTS.items():
        print(f"\n📦 Adding {category} products...")
        
        for idx, product in enumerate(items, 1):
            # Create document ID
            doc_id = f"{category.lower()}_{idx}"
            
            # Add to Firestore
            try:
                db.collection('products').document(doc_id).set({
                    'name': product['name'],
                    'category': category,
                    'price': product['price'],
                    'image': product['image']
                })
                print(f"  ✓ {product['name']} (Rs {product['price']})")
                total += 1
            except Exception as e:
                print(f"  ✗ Error adding {product['name']}: {e}")
    
    print(f"\n✅ Total products added: {total}")

if __name__ == '__main__':
    print("🚀 PetHub Products Importer")
    print("=" * 50)
    add_products()
    print("\n✨ Done!")
