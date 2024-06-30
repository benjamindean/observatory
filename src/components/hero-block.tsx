import classNames from "classnames";
import React from "react";

export default function HeroBlock({
  title,
  subtitle,
  imageUrls,
  backgroundTint,
  reversed,
  bottom,
}: {
  title: string;
  subtitle: JSX.Element[];
  imageUrls: string[];
  backgroundTint?: string;
  reversed?: boolean;
  bottom?: JSX.Element;
}) {
  return (
    <div
      className={classNames("hero", {
        [`${backgroundTint}`]: backgroundTint,
        "bg-base": !backgroundTint,
      })}
    >
      <div
        className={classNames(["hero-content", "flex-col"], {
          "lg:flex-row-reverse": reversed,
          "lg:flex-row": !reversed,
        })}
      >
        <div className="flex lg:w-1/2 justify-center items-center px-8 pb-[4.2rem] pt-8 w-full min-h-[480px] md:min-h-[680px]">
          <div className="flex relative min-h-[420px] min-w-[220px] md:h-[620px] md:w-[420px]">
            {imageUrls.map((imageUrl, index) => (
              <div
                className={classNames(["hover:z-50"], {
                  "absolute -top-0 -right-0": index === 0,
                  "absolute -left-0 -bottom-10": index === 1,
                })}
              >
                <img
                  className="rounded-3xl shadow-2xl h-[400px] md:h-[600px]"
                  src={imageUrl}
                  alt={title}
                />
              </div>
            ))}
          </div>
        </div>

        <div className="flex-col lg:w-1/2 px-8">
          <h1 className="text-5xl font-bold">{title}</h1>
          <p className="py-6">{subtitle}</p>
          {bottom}
        </div>
      </div>
    </div>
  );
}
