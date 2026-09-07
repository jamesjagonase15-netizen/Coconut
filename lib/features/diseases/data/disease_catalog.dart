import '../domain/entities/disease_info.dart';
import 'package:flutter/material.dart';

const List<DiseaseInfo> diseases = [
  DiseaseInfo(
    name: 'Bud Rot',
    icon: Icons.dangerous_outlined,
    color: Color(0xFFB71C1C),
    description:
        'Bud Rot is one of the most destructive diseases of coconut palms caused by the fungus Phytophthora palmivora. It attacks the growing point (bud) of the palm, which if destroyed, kills the entire tree.',
    symptoms: [
      'Yellowing and wilting of the youngest leaves',
      'Brown water-soaked lesions at the base of the spear leaf',
      'Foul smell from the rotting bud',
      'Easy pulling out of the spear leaf',
      'Rotting and collapse of the crown',
    ],
    remedies: [
      'Remove and destroy all infected plant parts',
      'Apply copper-based fungicide (e.g. Bordeaux mixture) to the bud area',
      'Drench the crown with Metalaxyl or Fosetyl-Al fungicide',
      'Avoid wounding the palm during farm operations',
    ],
    prevention: [
      'Ensure proper drainage around the base of the palm',
      'Avoid water logging in the plantation',
      'Apply preventive fungicide sprays during rainy season',
      'Remove and burn infected palms immediately',
    ],
  ),
  DiseaseInfo(
    name: 'Crown Rot',
    icon: Icons.coronavirus_outlined,
    color: Color(0xFFE65100),
    description:
        'Crown Rot is a fungal disease that affects the crown of the coconut palm. It is caused by various fungal pathogens and thrives in wet and humid conditions, leading to the decay of the crown tissues.',
    symptoms: [
      'Browning and rotting of crown leaves',
      'Dark water-soaked lesions at the crown base',
      'Drooping and death of fronds starting from the center',
      'Foul odor from decaying crown tissue',
      'Discoloration of inner crown tissues',
    ],
    remedies: [
      'Cut and remove all infected crown tissues',
      'Apply systemic fungicide such as Carbendazim or Copper oxychloride',
      'Treat wounds with Bordeaux paste after pruning',
      'Improve air circulation around the crown',
    ],
    prevention: [
      'Avoid injuries to the crown during harvesting',
      'Maintain proper plant spacing for air circulation',
      'Apply preventive fungicide during wet season',
      'Monitor palms regularly especially after heavy rains',
    ],
  ),
  DiseaseInfo(
    name: 'Gray Leaf Blight',
    icon: Icons.blur_on,
    color: Color(0xFF4E342E),
    description:
        'Gray Leaf Blight is a fungal disease caused by Pestalotiopsis palmarum. It primarily affects the leaves of coconut palms and is common in plantations with high humidity and poor air circulation.',
    symptoms: [
      'Grayish-brown spots on leaflets',
      'Spots with yellow halos on leaf surface',
      'Premature drying and death of leaflets',
      'Dark fruiting bodies visible on lesions',
      'Blighting starting from leaf tips',
    ],
    remedies: [
      'Remove and burn severely infected fronds',
      'Apply Mancozeb or Copper-based fungicide',
      'Spray Chlorothalonil on affected leaves',
      'Improve farm sanitation by removing dead plant materials',
    ],
    prevention: [
      'Maintain adequate spacing between palms',
      'Avoid excessive nitrogen fertilization',
      'Keep the plantation free of weeds and debris',
      'Apply preventive fungicide sprays during humid months',
    ],
  ),
  DiseaseInfo(
    name: 'Leaf Spot',
    icon: Icons.circle_outlined,
    color: Color(0xFF827717),
    description:
        'Leaf Spot is a common fungal disease of coconut caused by Helminthosporium, Curvularia, or other fungal species. It causes spots on the leaves that can reduce photosynthesis and weaken the palm over time.',
    symptoms: [
      'Small round to oval spots on leaflets',
      'Spots are brown to dark brown with yellow margins',
      'Spots may coalesce forming larger dead areas',
      'Premature yellowing and drying of leaves',
      'Reduced leaf area due to extensive spotting',
    ],
    remedies: [
      'Remove badly infected leaves and destroy them',
      'Spray Mancozeb, Zineb, or Copper fungicides',
      'Apply balanced fertilizers to boost plant immunity',
      'Use Propiconazole for severe infections',
    ],
    prevention: [
      'Avoid overhead irrigation that wets the leaves',
      'Remove fallen leaves and debris from the plantation',
      'Apply potassium fertilizer to strengthen leaves',
      'Monitor regularly and treat early signs of infection',
    ],
  ),
  DiseaseInfo(
    name: 'Lethal Yellowing',
    icon: Icons.warning_amber_outlined,
    color: Color(0xFFF9A825),
    description:
        'Lethal Yellowing is a deadly disease caused by a phytoplasma (a bacteria-like organism) transmitted by the planthopper insect Myndus crudus. It is one of the most devastating coconut diseases worldwide with no known cure once symptoms appear.',
    symptoms: [
      'Premature dropping of coconuts at all stages',
      'Blackening of flower stalks (inflorescence)',
      'Progressive yellowing of fronds starting from the bottom',
      'Yellowing spreads upward until entire crown is yellow',
      'Death of the growing point and eventual palm death',
    ],
    remedies: [
      'Inject Oxytetracycline antibiotic into the trunk every 3-4 months',
      'This only suppresses symptoms but does not cure the disease',
      'Remove and destroy infected palms to prevent spread',
      'Control the insect vector using appropriate insecticides',
    ],
    prevention: [
      'Plant resistant coconut varieties (e.g. Malayan Dwarf)',
      'Control planthopper populations with insecticide',
      'Remove and replace infected palms immediately',
      'Avoid planting susceptible varieties in affected areas',
    ],
  ),
  DiseaseInfo(
    name: 'Nutrient Deficiency',
    icon: Icons.science_outlined,
    color: Color(0xFF1565C0),
    description:
        'Nutrient Deficiency in coconut palms occurs when essential minerals like Potassium, Magnesium, Boron, or Nitrogen are lacking in the soil. It weakens the palm and makes it more susceptible to diseases and pests.',
    symptoms: [
      'Yellowing of older leaves (Nitrogen or Magnesium deficiency)',
      'Orange-yellow discoloration of fronds (Potassium deficiency)',
      'Stunted new leaf growth (Boron deficiency)',
      'Small or deformed nuts',
      'Overall pale and weak appearance of the palm',
    ],
    remedies: [
      'Apply complete fertilizer (NPK) based on soil test results',
      'Apply Muriate of Potash for Potassium deficiency',
      'Apply Magnesium Sulfate (Epsom salt) for Magnesium deficiency',
      'Apply Borax solution for Boron deficiency',
    ],
    prevention: [
      'Conduct regular soil testing every 2-3 years',
      'Follow a regular fertilization schedule',
      'Apply organic matter and compost to improve soil health',
      'Ensure proper irrigation to help nutrient uptake',
    ],
  ),
];

// ─────────────────────────────────────────────
// MENU SCREEN
