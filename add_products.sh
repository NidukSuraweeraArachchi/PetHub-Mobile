#!/bin/bash
# Firebase Products Database Setup Script
# This script adds all products to Firestore using REST API

# ============================================
# Configuration
# ============================================
PROJECT_ID="pethub-app-a0f7a"
FIRESTORE_URL="https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents"

# Get your Firebase ID token first from:
# https://console.firebase.google.com/ -> Settings -> Service Accounts -> Create Private Key
# Or use the REST API directly in browser

echo "Adding Products to Firestore..."
echo "Project: $PROJECT_ID"
echo ""

# ============================================
# Function to add a product
# ============================================
add_product() {
    local doc_id=$1
    local name=$2
    local category=$3
    local price=$4
    local image=$5

    echo "Adding: $name ($category) - Rs $price"
    
    curl -X POST \
        "${FIRESTORE_URL}/products" \
        -H "Content-Type: application/json" \
        -d '{
            "fields": {
                "name": {"stringValue": "'$name'"},
                "category": {"stringValue": "'$category'"},
                "price": {"integerValue": '$price'},
                "image": {"stringValue": "'$image'"}
            }
        }' 2>/dev/null

    echo ""
}

# ============================================
# Add all products
# ============================================

echo "=== TOYS ==="
add_product "toys_pedigree_10kg" "Pedigree 10kg" "Toys" "2490" "assets/eating.jfif"
add_product "toys_pedigree_pro" "PedigreePro 1.2kg" "Toys" "458" "assets/eating.jfif"
add_product "toys_henlo_dry" "Henlo Dry" "Toys" "39" "assets/eating.jfif"
add_product "toys_royal_canin" "Royal Canin" "Toys" "990" "assets/eating.jfif"
add_product "toys_canine_greek" "Canine Greek" "Toys" "684" "assets/eating.jfif"
add_product "toys_dog_bikkit" "Dog Bikkit" "Toys" "320" "assets/eating.jfif"
add_product "toys_puppy_snacks" "Puppy Snacks" "Toys" "250" "assets/eating.jfif"

echo "=== CLOTHES ==="
add_product "clothes_woven_dress" "Woven Dress" "Clothes" "684" "assets/clothes.jfif"
add_product "clothes_pet_shirt" "Pet Shirt" "Clothes" "450" "assets/clothes.jfif"
add_product "clothes_sweater" "Pet Sweater" "Clothes" "750" "assets/clothes.jfif"
add_product "clothes_raincoat" "Pet Raincoat" "Clothes" "1200" "assets/clothes.jfif"
add_product "clothes_jacket" "Pet Jacket" "Clothes" "900" "assets/clothes.jfif"

echo "=== FOOD ==="
add_product "food_pedigree_10kg" "Pedigree 10kg" "Food" "2490" "assets/eating.jfif"
add_product "food_pedigree_pro" "PedigreePro 1.2kg" "Food" "458" "assets/eating.jfif"
add_product "food_henlo_dry" "Henlo Dry" "Food" "39" "assets/eating.jfif"
add_product "food_royal_canin" "Royal Canin" "Food" "990" "assets/eating.jfif"
add_product "food_canine_greek" "Canine Greek" "Food" "684" "assets/eating.jfif"
add_product "food_dog_bikkit" "Dog Bikkit" "Food" "320" "assets/eating.jfif"
add_product "food_puppy_snacks" "Puppy Snacks" "Food" "250" "assets/eating.jfif"

echo "=== MEDICINE ==="
add_product "medicine_alfalfa" "Alfalfa tonic" "Medicine" "250" "assets/medicine.jfif"
add_product "medicine_diarrhoea" "Diarrhoea tablets" "Medicine" "90" "assets/medicine.jfif"
add_product "medicine_thirst_drop" "Drop for excessive thirst" "Medicine" "100" "assets/medicine.jfif"
add_product "medicine_ear_drop" "Ear drop" "Medicine" "130" "assets/medicine.jfif"
add_product "medicine_wound_lotion" "Wound lotion" "Medicine" "684" "assets/medicine.jfif"
add_product "medicine_joint_tablets" "Joint Tablets" "Medicine" "180" "assets/medicine.jfif"
add_product "medicine_liv_52" "Liv 52 metabolism" "Medicine" "350" "assets/medicine.jfif"
add_product "medicine_multivitamin" "Multivitamin for pets" "Medicine" "350" "assets/medicine.jfif"

echo "=== ACCESSORIES ==="
add_product "accessories_muzzle" "Mouth Cover muzzles" "Accessories" "2490" "assets/accessories.jfif"
add_product "accessories_brush" "Hair Brush" "Accessories" "450" "assets/accessories.jfif"
add_product "accessories_bed" "Portable Bed" "Accessories" "1800" "assets/accessories.jfif"
add_product "accessories_harness" "Dog Harness" "Accessories" "990" "assets/accessories.jfif"
add_product "accessories_leash" "Dog leash" "Accessories" "340" "assets/accessories.jfif"
add_product "accessories_retractable_leash" "Retractable Dog Leash" "Accessories" "720" "assets/accessories.jfif"
add_product "accessories_bowl" "Food Bowl 700ml" "Accessories" "270" "assets/accessories.jfif"

echo ""
echo "✓ All products added to Firestore!"
