using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Erun360.Model.DB5;
/// <summary>
/// SmartChooseShoes 的摘要说明
/// </summary>
public class SmartChooseShoes
{
    public Runner StandardMan = new Runner();
    public Runner StandardWoman = new Runner();
    public SmartChooseShoes()
    {
        StandardMan.Gender = 0;
        StandardMan.Tall = 170;
        StandardMan.Weight = 64;
        StandardMan.TypeOfShoe = "road";
        StandardMan.Level = "beginner";
        StandardMan.RunInATypicalWeek = "1-8";
        StandardMan.AveragePace = 225;
        StandardMan.InjuredLast12Months = "notatall";
        StandardMan.HighOfArch = "medium";
        StandardMan.MotionMechanics = "normal";
        StandardMan.StrikeTheGround = "midfoot";
        StandardMan.WeightPercent = 42;
        StandardMan.HeightPercent = 42;
        StandardMan.HeelCushionPercent = 54;
        StandardMan.ForefootCushionPercent = 54;
        StandardMan.StiffnessPercent = 42;
        StandardMan.StabilityPercent = 37;

        StandardWoman.Gender = 1;
        StandardWoman.Tall = 160;
        StandardWoman.Weight = 50;
        StandardWoman.TypeOfShoe = "road";
        StandardWoman.Level = "beginner";
        StandardWoman.RunInATypicalWeek = "1-8";
        StandardWoman.AveragePace = 225;
        StandardWoman.InjuredLast12Months = "notatall";
        StandardWoman.HighOfArch = "medium";
        StandardWoman.MotionMechanics = "normal";
        StandardWoman.StrikeTheGround = "midfoot";
        StandardWoman.WeightPercent = 27;
        StandardWoman.HeightPercent = 27;
        StandardWoman.HeelCushionPercent = 67;
        StandardWoman.ForefootCushionPercent = 66;
        StandardWoman.StiffnessPercent = 17;
        StandardWoman.StabilityPercent = 30;
    }
    public Runner GetPercentRanking(Runner pararunner)
    {
        Runner runnerPercentRanking = new Runner();
        Erun360.BLL.DB5.tbl_SmartChooseShoes BLLtbl_SmartChooseShoes = new Erun360.BLL.DB5.tbl_SmartChooseShoes();
        tbl_SmartChooseShoes OriginalSmart = new tbl_SmartChooseShoes();
        OriginalSmart.changeweight = 0m;
        OriginalSmart.changeheight = 0m;
        OriginalSmart.changeheelcushion = 0m;
        OriginalSmart.changeforefootcushion = 0m;
        OriginalSmart.changestability = 0m;
        OriginalSmart.changestiffness = 0m;
        Runner StandardRunner = new Runner();
        switch (pararunner.Gender)
        {
            case 0://男
                StandardRunner = StandardMan;
                break;
            case 1:
                StandardRunner = StandardWoman;
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes TallSmart = OriginalSmart;
        if (StandardRunner.Tall != pararunner.Tall)
        {
            TallSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "tall");
        }
        tbl_SmartChooseShoes WeightSmart = OriginalSmart;
        if (StandardRunner.Weight != pararunner.Weight)
        {
            WeightSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "weight");
        }
        tbl_SmartChooseShoes LevelSmart = OriginalSmart;
        switch (pararunner.Level)
        {
            case "intermediate":
                LevelSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "intermediate");
                break;
            case "advanced":
                LevelSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "advanced");
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes RunMilesSmart = OriginalSmart;
        switch (pararunner.RunInATypicalWeek)
        {
            case "8-16":
                RunMilesSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "8-16");
                break;
            case "16-32":
                RunMilesSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "16-32");
                break;
            case "32-48":
                RunMilesSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "32-48");
                break;
            case ">48":
                RunMilesSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, ">48");
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes AveragePaceSmart = OriginalSmart;
        if (StandardRunner.AveragePace != pararunner.AveragePace)
        {
            AveragePaceSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "averagepace");
        }
        tbl_SmartChooseShoes InjuredSmart = OriginalSmart;
        switch (pararunner.InjuredLast12Months)
        {
            case "minor":
                InjuredSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "minor");
                break;
            case "major":
                InjuredSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "major");
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes HighOfArchSmart = OriginalSmart;
        switch (pararunner.HighOfArch)
        {
            case "flat":
                HighOfArchSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "flat");
                break;
            case "high":
                HighOfArchSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "high");
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes MotionMechanicsSmart = OriginalSmart;
        switch (pararunner.MotionMechanics)
        {
            case "underpronator":
                MotionMechanicsSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "underpronator");
                break;
            case "overpronator":
                MotionMechanicsSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "overpronator");
                break;
            default:
                break;
        }
        tbl_SmartChooseShoes HowStrikeSmart = OriginalSmart;
        switch (pararunner.StrikeTheGround)
        {
            case "forefoot":
                HowStrikeSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "forefoot");
                break;
            case "heel":
                HowStrikeSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "heel");
                break;
            case "extremheel":
                HowStrikeSmart = BLLtbl_SmartChooseShoes.GetModelByGenderAndFactor(pararunner.Gender, "extremheel");
                break;
            default:
                break;
        }
        runnerPercentRanking.WeightPercent = StandardRunner.WeightPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changeweight + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changeweight + LevelSmart.changeweight + RunMilesSmart.changeweight + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changeweight + InjuredSmart.changeweight + HighOfArchSmart.changeweight + MotionMechanicsSmart.changeweight + HowStrikeSmart.changeweight;

        runnerPercentRanking.HeightPercent = StandardRunner.HeightPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changeheight + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changeheight + LevelSmart.changeheight + RunMilesSmart.changeheight + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changeheight + InjuredSmart.changeheight + HighOfArchSmart.changeheight + MotionMechanicsSmart.changeheight + HowStrikeSmart.changeheight;

        runnerPercentRanking.HeelCushionPercent = StandardRunner.HeelCushionPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changeheelcushion + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changeheelcushion + LevelSmart.changeheelcushion + RunMilesSmart.changeheelcushion + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changeheelcushion + InjuredSmart.changeheelcushion + HighOfArchSmart.changeheelcushion + MotionMechanicsSmart.changeheelcushion + HowStrikeSmart.changeheelcushion;

        runnerPercentRanking.ForefootCushionPercent = StandardRunner.ForefootCushionPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changeforefootcushion + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changeforefootcushion + LevelSmart.changeforefootcushion + RunMilesSmart.changeforefootcushion + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changeforefootcushion + InjuredSmart.changeforefootcushion + HighOfArchSmart.changeforefootcushion + MotionMechanicsSmart.changeforefootcushion + HowStrikeSmart.changeforefootcushion;

        runnerPercentRanking.StiffnessPercent = StandardRunner.StiffnessPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changestiffness + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changestiffness + LevelSmart.changestiffness + RunMilesSmart.changestiffness + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changestiffness + InjuredSmart.changestiffness + HighOfArchSmart.changestiffness + MotionMechanicsSmart.changestiffness + HowStrikeSmart.changestiffness;

        runnerPercentRanking.StabilityPercent = StandardRunner.StabilityPercent + (pararunner.Tall - StandardRunner.Tall) * TallSmart.changestability + (pararunner.Weight - StandardRunner.Weight) * WeightSmart.changestability + LevelSmart.changestability + RunMilesSmart.changestability + (pararunner.AveragePace - StandardRunner.AveragePace) * AveragePaceSmart.changestability + InjuredSmart.changestability + HighOfArchSmart.changestability + MotionMechanicsSmart.changestability + HowStrikeSmart.changestability;

        return runnerPercentRanking;
    }
}
public class Runner
{
    public int Gender { get; set; }

    public decimal? Tall { get; set; }

    public decimal? Weight { get; set; }

    public string TypeOfShoe { get; set; }

    public string Level { get; set; }

    public string RunInATypicalWeek { get; set; }

    public decimal? AveragePace { get; set; }

    public string InjuredLast12Months { get; set; }

    public string HighOfArch { get; set; }

    public string MotionMechanics { get; set; }

    public string StrikeTheGround { get; set; }

    public decimal? WeightPercent { get; set; }

    public decimal? HeightPercent { get; set; }

    public decimal? HeelCushionPercent { get; set; }

    public decimal? ForefootCushionPercent { get; set; }

    public decimal? StiffnessPercent { get; set; }

    public decimal? StabilityPercent { get; set; }
}