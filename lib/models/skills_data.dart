import '../components/skills.dart';

class SkillsData{
  final Map<StrengthSkills,bool> strenghtSkills;
  final Map<WisdomSkills,bool> wisdomSkills;
  final Map<DexteritySkills,bool> dexteritySkills;
  final Map<CharismaSkills,bool> charismaSkills;
  final Map<StrengthSkills,bool> constitutionSkills;
  final Map<IntelligenceSkills,bool> intelligenceSkills;

  SkillsData(this.strenghtSkills, this.wisdomSkills, this.dexteritySkills,
      this.charismaSkills, this.constitutionSkills, this.intelligenceSkills);
}